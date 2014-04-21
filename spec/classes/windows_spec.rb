require 'spec_helper'

describe 'win32ole_vs_facter::windows' do
  let(:facts) do
    {
      kernel: 'windows'
    }
  end

  it { should contain_notify('windows') }
end
