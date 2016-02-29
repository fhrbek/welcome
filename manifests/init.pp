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
    content => '<html><body>PUG is awesome!</body></html>',
    notify => Service['nginx'],
  }

  file { '/etc/nginx/default.conf':
    ensure => file,
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    require => [
      Package['nginx'],
      File['/var/pug/index.html','/etc/nginx/default.conf'],
    ]
  }
}
