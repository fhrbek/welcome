# Class: welcome
# ===========================
#
class welcome (
    $port = 8888,
  ) {

  package { 'nginx':
    ensure => present,
  }

  file { ['/var', '/var/pug']:
    ensure => directory
  }

  file { '/var/pug/index.html':
    ensure => file,
    content => template('welcome/index.html.erb'),
    notify => Service['nginx'],
  }

  file { ['/etc/nginx', '/etc/nginx/conf.d']:
    ensure => directory
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    content => template('welcome/default.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    require => [
      Package['nginx'],
      File['/var/pug/index.html','/etc/nginx/conf.d/default.conf'],
    ]
  }
}
