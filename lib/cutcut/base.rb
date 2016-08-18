module CutCut
  # Base
  class Base
    attr_reader :input, :output

    def initialize(options = {})
      @input = options.delete(:input)
      @output = options.delete(:output)
    end

    def original_date_time
      exif = MiniExiftool.new(@input)
      Date.parse(exif.date_time_original || exif.create_date || exif.modify_date).strftime
    end

    private

    def execute_ffmpeg_command(options = {})
      system("ffmpeg #{options[:raw_options].try(:[], :input)} \
             -i #{options.delete(:input) || @input} \
             #{options[:raw_options].try(:[], :output)} \
             #{options.delete(:output) || @output} \
             -y > /dev/null 2>&1")
    end
  end
end
