module CutCut
  # Media
  class Media
    attr_reader :file, :output_path

    def initialize(file, options = {})
      @file = file
      @output_path = options['output_path'] || File.dirname(file)
    end

    def convert(options = {})
      scale = options[:scale]
      output_file = options[:output_file] || File.join(@output_path, File.basename(file))
      # system("ffmpeg -i #{@file} -movflags +faststart -vf scale=-2:1080 -c:v libx264 -crf 20 -preset ultrafast #{output_file}")
      system("ffmpeg -i #{@file} -movflags +faststart -vf scale=#{scale} -c:v libx264 -crf 20 -preset ultrafast #{output_file}")
    end

    def copy_exif_from_original_file
      @output_exif = MiniExiftool.new(@output_file)
      @output_exif.copy_tags_from(@path, '*')
      @output_exif.date_time_original = original_date
      @output_exif.create_date = original_date
      @output_exif.modify_modify_date = original_date
      @output_exif.save
    end
  end
end
