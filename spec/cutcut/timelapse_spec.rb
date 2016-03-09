require 'spec_helper'

describe CutCut::Timelapse do
  let(:timelapse) do
    CutCut::Timelapse.new(
      input: File.join(File.dirname(__FILE__), '../fixtures/timelapse'),
      output: File.join(File.dirname(__FILE__), '../fixtures/timelapse.mp4')
    )
  end

  it 'has input and output' do
    expect(timelapse.input).to_not eq(nil)
    expect(timelapse.output).to_not eq(nil)
  end

  it 'return list of files' do
    expect(timelapse.files.count).to eq(2)
  end
end
