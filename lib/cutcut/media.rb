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

      execute_ffmpeg_command(
        input_file: @file,
        output_file: output_file,
        raw_options: "-movflags +faststart -vf scale=#{scale} -c:v libx264 -crf 20 -preset ultrafast"
      )

      copy_metadata(@file, output_file) if copy_metadata
      output_file
    end

    def extract_screenshots(options = {})
      fps = options[:fps] || 1
      basename = options[:basename] || File.basename(@file, '.MP4') + '_screenshot'
      basename += '%d.jpg'

      execute_ffmpeg_command(
        input_file: @file,
        output_file: "#{output_path}/#{basename}",
        raw_options: "-vf fps=#{fps}"
      )
    end

    def cut(options = {})
      starts_at = options[:start] || '00:00'
      time = options[:time] || 1

      execute_ffmpeg_command(
        input_file: @file,
        output_file: "#{output_path}/cut.mp4",
        raw_options: "-ss #{starts_at} -t #{time} "
      )
    end

    def copy_metadata(origin, target)
      exif = MiniExiftool.new(target)
      exif.copy_tags_from(origin, '*')
    end

    private

    def execute_ffmpeg_command(options = {})
      input_file = options.delete(:input_file)
      output_file = options.delete(:output_file)
      raw_options = options.delete(:raw_options)
      system("ffmpeg -i #{input_file} #{raw_options} #{output_file} -y > /dev/null 2>&1")
    end
  end
end
