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

    def copy_exif_from_original_file
      @output_exif = MiniExiftool.new(@output_file)
      @output_exif.copy_tags_from(@path, "*")
      @output_exif.date_time_original = original_date
      @output_exif.create_date = original_date
      @output_exif.modify_modify_date = original_date
      @output_exif.save
    end
  end
end
