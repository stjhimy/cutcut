module CutCut
  # Media
  class Media
    attr_reader :file, :output_path

    def initialize(file, options = {})
      @file = file
      @output_path = options['output_path'] || File.dirname(file)
    end

    def convert(options = {})
      scale = options[:scale] # Examples: 1920:1080 -2:1080 -2:720
      copy_metadata = options[:copy_metadata] || false

      output_file = options[:output_file] || File.join(@output_path, '__' + File.basename(file))
      system("ffmpeg -i #{@file} -movflags +faststart -vf scale=#{scale} -c:v libx264 -crf 20 -preset ultrafast #{output_file} -y > /dev/null 2>&1")

      copy_metadata(@file, output_file) if copy_metadata
      output_file
    end

    def extract_screenshots
      system("ffmpeg -i #{@file} -vf fps=1 #{output_path}/out%d.png")
    end

    def copy_metadata(origin, target)
      exif = MiniExiftool.new(target)
      exif.copy_tags_from(origin, '*')
    end
  end
end
