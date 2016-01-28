module CutCut
  # Media
  class Media
    def initialize(options = {})
      @path = options[:path]
    end

    def convert(options = {})
    end

    def convert(options={})
      @output_file = File.join(@output_path, @file_name + @file_extension)
      system("ffmpeg -i #{@path} -movflags +faststart -vf scale=-2:1080 -c:v libx264 -crf 20 -preset ultrafast #{@output_file}") unless converted?
    end

  end
end
