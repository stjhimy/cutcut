require 'rubygems'
require 'bundler/setup'

require 'cutcut'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!

  config.before(:all) do
    system("rm -rf #{File.join(File.dirname(__FILE__), '/fixtures/*.MP4')}")
    system("rm -rf #{File.join(File.dirname(__FILE__), '/fixtures/*.mp4')}")
    system("cp #{File.join(File.dirname(__FILE__), '/fixtures/example')} #{File.join(File.dirname(__FILE__), '/fixtures/example.MP4')}")
  end

  config.before(:each) do
    %w(jpg JPG png PNG).each do |extension|
      system("rm -rf #{File.join(File.dirname(__FILE__), '/fixtures/*.' + extension)}")
    end
  end

  config.after(:all) do
    %w(jpg JPG png PNG mp4 MP4).each do |extension|
      system("rm -rf #{File.join(File.dirname(__FILE__), '/fixtures/*.' + extension)}")
    end
  end
end
