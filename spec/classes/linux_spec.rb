require 'spec_helper'

describe 'win32ole_vs_facter::linux' do
  let(:facts) do
    {
      kernel: 'Linux'
    }
  end

  it { should contain_notify('linux') }
end
