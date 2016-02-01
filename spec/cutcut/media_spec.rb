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

  it 'initialize' do
    expect(media.file).to_not eq(nil)
    expect(media.output_path).to_not eq(nil)
  end

  it 'convert' do
    expect(File.exist?(media.convert(scale: '1920:1080'))).to eq true
  end
end
