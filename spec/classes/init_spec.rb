require 'spec_helper'
describe 'welcome' do

  context 'with default values for all parameters' do
    it { should contain_class('welcome') }
  end
end
