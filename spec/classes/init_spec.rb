require 'spec_helper'
describe 'puppetagent' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetagent') }
  end
end
