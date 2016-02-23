require 'spec_helper'

describe CutCut::Media do
  before(:all) do
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/example.MP4')}")
    system("rm -rf #{File.join(File.dirname(__FILE__), '../fixtures/cut.MP4')}")
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
    CutCut::Media.new(input_file: File.join(File.dirname(__FILE__), '../fixtures/example.MP4'))
  end

  describe 'initialize' do
    it 'initialize accessors' do
      expect(media.input_file).to_not eq(nil)
      expect(media.output_path).to_not eq(nil)
    end

    it 'return create_date tag' do
      expect(media.original_date_time).to eq('2016-01-25 20:15:35 -0200')
    end
  end

  describe 'convert' do
    it 'convert media' do
      expect(File.exist?(media.convert(scale: '1920:1080'))).to eq true
    end

    it 'copy metadata' do
      source = MiniExiftool.new(media.input_file)
      target = MiniExiftool.new(media.convert(scale: '1920:1080', copy_metadata: true))
      expect(source.create_date).to eq(target.create_date)
    end
  end

  describe 'cut' do
    it 'cut the video' do
      media.cut(starts_at: '00:00', time: '0.5')
      expect(File.exist?(File.join(File.dirname(__FILE__), '../fixtures/cut.mp4'))).to eq(true)
    end
  end

  describe 'extract_screenshots' do
    it 'default file to _screenshot' do
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/*_screenshot*.jpg')).count).to eq(0)
      media.extract_screenshots(copy_metadata: false)
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/*_screenshot*.jpg')).count).to eq(2)
    end

    it 'allow to save screenshots with a basename' do
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/out*.jpg')).count).to eq(0)
      media.extract_screenshots(basename: 'out', copy_metadata: false)
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/out*.jpg')).count).to eq(2)
    end

    it 'extract screenshots based on fps' do
      media.extract_screenshots(fps: 1, copy_metadata: true)
      files = Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/*_screenshot*.jpg'))
      expect(files.count).to eq(2)
      files.each do |file|
        expect(MiniExiftool.new(file).create_date).to be >= media.original_date_time
      end
    end

    it 'copy_metadata to screenshots' do
      media.extract_screenshots(fps: 3, copy_metadata: false)
      expect(Dir.glob(File.join(File.dirname(__FILE__), '../fixtures/*_screenshot*.jpg')).count).to eq(4)
    end
  end
end
