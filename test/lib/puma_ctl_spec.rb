require_relative './spec_helper'
require_relative '../lib/sensu-plugins-puma/puma_ctl'

describe PumaCtl do
  subject(:puma_ctl) {PumaCtl.new(state_file: state_file_path, control_auth_token: control_auth_token, control_url: control_url)}
  let(:control_auth_token) {nil}
  let(:control_url) {nil}
  let(:state_file_path) {File.join(File.dirname(__FILE__), "support/v#{version}.state")}
  let(:version) {nil}

  context 'configuration' do
    context 'with control options' do
      let(:control_auth_token) {'123'}
      let(:control_url) {'unix:///some/path'}

      it 'accepts a `control_auth_token`' do
        expect(puma_ctl.control_auth_token).to eq('123')
      end

      it 'accepts a `control-url` option' do
        expect(puma_ctl.control_url).to eq('unix:///some/path')
      end
    end

    context "with a < v3.0.0 state file" do
      let(:version) {'2x'}

      it "parses correctly" do
        expect(puma_ctl.control_auth_token).to eq('abcde')
        expect(puma_ctl.control_url).to eq('unix:///app/pumactl.sock')
      end
    end

    context "with a >= v3.0.0 state file" do
      let(:version) {'3x'}

      it "parses correctly" do
        expect(puma_ctl.control_auth_token).to eq('123456')
        expect(puma_ctl.control_url).to eq('unix:///app/pumactl.sock')
      end
    end
  end


end
