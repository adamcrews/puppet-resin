require 'spec_helper'

describe 'resin' do
  context 'supported operating systems' do
    ['RedHat', 'Amazon'].each do |osfamily|
      describe "resin class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('resin::params') }
        it { should contain_class('resin::install').that_comes_before('resin::config') }
        it { should contain_class('resin::config') }
        it { should contain_class('resin::service').that_subscribes_to('resin::config') }

        it { should contain_service('resin') }
        it { should contain_package('resin').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'resin class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('resin') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
