require 'spec_helper'

describe CutCut::Timelapse do
  let(:timelapse) do
    CutCut::Timelapse.new(
      input: File.join(File.dirname(__FILE__), '../fixtures/timelapse/'),
      output: File.join(File.dirname(__FILE__), '../fixtures/timelapse.mp4')
    )
  end

  it 'has input and output' do
    expect(timelapse.input).to_not eq(nil)
    expect(timelapse.output).to_not eq(nil)
  end

  it 'return list of files' do
    expect(timelapse.files.count).to eq(2)
    timelapse.start_number
  end

  it 'return list of file basenames' do
    expect(timelapse.basenames.count).to eq(2)
    expect(timelapse.basenames.first).to eq('G0023026')
  end

  it 'return start_number based on first file name' do
    expect(timelapse.start_number).to eq('6')
  end

  it 'return input_basename based on common string and start_number' do
    expect(timelapse.input_basename).to eq('G002302%1d.JPG')
  end

  it 'should convert and create timelapse' do
    expect(File.exist?(timelapse.output)).to eq false
    expect(File.exist?(timelapse.convert(fps: '1'))).to eq true
    expect(MiniExiftool.new(timelapse.output).duration).to eq('1.03 s')
  end

  it 'has original_date_time and copy from first file' do
    expect(timelapse.original_date_time).to eq(MiniExiftool.new(timelapse.output).date_time_original)
  end
end
