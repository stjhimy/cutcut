require 'spec_helper'

describe CutCut::Base do
  before(:all) do
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/*.MP4')}")
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/*.mp4')}")
    system("cp #{File.join(File.dirname(__FILE__), '../fixtures/example')} #{File.join(File.dirname(__FILE__), '../fixtures/example.MP4')}")
  end

  it 'has input and output' do
    base = CutCut::Base.new(input: 'input', output: 'output')
    expect(base.input).to eq('input')
    expect(base.output).to eq('output')
  end

  it 'has original_date_time' do
    base = CutCut::Base.new(input: File.join(File.dirname(__FILE__), '../fixtures/example.MP4'), output: 'output')
    expect(base.original_date_time).to eq('2016-01-25 20:15:35 -0200')
  end
end
