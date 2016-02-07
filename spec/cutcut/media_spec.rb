require 'spec_helper'

describe CutCut::Media do
  before(:all) do
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/example.MP4')}")
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/__example.MP4')}")
    system("cp #{File.join(File.dirname(__FILE__), '../fixtures/_example.MP4')} #{File.join(File.dirname(__FILE__), '../fixtures/example.MP4')}")
  end

  before(:each) do
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/*.jpg')}")
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/*.png')}")
  end

  after(:all) do
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/*.jpg')}")
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/*.png')}")
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

  describe 'extract_screenshots' do
    it 'default file to _screenshot' do
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/*_screenshot*.jpg')).count).to eq(0)
      media.extract_screenshots
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/*_screenshot*.jpg')).count).to eq(2)
    end

    it 'allow to save screenshots with a basename' do
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/out*.jpg')).count).to eq(0)
      media.extract_screenshots(basename: 'out')
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/out*.jpg')).count).to eq(2)
    end

    it 'extract screenshots based on fps' do
      media.extract_screenshots(fps: 3)
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/*_screenshot*.jpg')).count).to eq(4)
    end
  end
end
