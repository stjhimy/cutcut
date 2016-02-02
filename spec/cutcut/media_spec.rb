require 'spec_helper'

describe CutCut::Media do
  before(:all) do
    system("rm #{File.join(File.dirname(__FILE__), '../fixtures/example.MP4')}")
    system("rm #{File.join(File.dirname(__FILE__), '../fixtures/__example.MP4')}")
    system("cp #{File.join(File.dirname(__FILE__), '../fixtures/_example.MP4')} #{File.join(File.dirname(__FILE__), '../fixtures/example.MP4')}")
  end

  after(:all) do
  end

  let(:media) do
    CutCut::Media.new(File.join(File.dirname(__FILE__), '../fixtures/example.MP4'))
  end

  it 'initialize accessors' do
    expect(media.file).to_not eq(nil)
    expect(media.output_path).to_not eq(nil)
  end

  it 'convert media' do
    expect(File.exist?(media.convert(scale: '1920:1080'))).to eq true
  end

  it 'copy metadata' do
    source = MiniExiftool.new(media.file)
    target = MiniExiftool.new(media.convert(scale: '1920:1080', copy_metadata: true))
    expect(source.create_date).to eq(target.create_date)
  end

  it 'extract_screenshots' do
    media.extract_screenshots
  end
end
