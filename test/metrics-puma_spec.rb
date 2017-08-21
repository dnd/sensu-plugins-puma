require_relative './spec_helper'
require_relative '../bin/metrics-puma'
require 'pry'

describe PumaMetrics do
  subject(:metric) {PumaMetrics.new(args)}
  let(:args) {}

  context 'with options' do
    let(:args) {%w(--state-file /some/file.state --auth-token 123 --control-url unix:///some/path)}

    it 'correctly instantiates a PumaCtl instnace' do
      # poor test
      expect(PumaCtl).to receive(:new).with(state_file: '/some/file.state', control_auth_token: '123', control_url: 'unix:///some/path')
      metric.puma_ctl
    end
  end

  describe '#run' do
  end
end
