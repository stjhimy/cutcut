module CutCut
  # Media
  class Media < Base
    attr_reader :output_path, :input_file

    def initialize(options = {})
      @input_file = options[:input_file]
      @output_path = options['output_path'] || File.dirname(input_file)
    end

    def convert(options = {})
      scale = options[:scale]
      speed = "-filter:v \"setpts=#{options[:speed]}*PTS\"" if options[:speed]
      copy_metadata = options[:copy_metadata] || false
      output_file = options[:output_file] || File.join(@output_path, '__' + File.basename(input_file))

      raw_options = "-movflags +faststart -vf scale=#{scale} -c:v libx264 -crf 20 -preset ultrafast  #{speed}"
      execute_ffmpeg_command(input_file: input_file, output_file: output_file, raw_options: { output: raw_options })

      copy_metadata(input_file, output_file) if copy_metadata
      output_file
    end

    def extract_screenshots(options = {})
      fps = options[:fps] || 1
      basename = options[:basename] || File.basename(input_file, '.MP4') + '_screenshot'
      copy_metadata = options[:copy_metadata]

      execute_ffmpeg_command(
        input_file: input_file,
        output_file: "#{output_path}/#{basename}%d.jpg",
        raw_options: { output: "-vf fps=#{fps}" }
      )

      copy_metadata_to_screenshots(basename, fps) if copy_metadata
    end

    def cut(options = {})
      starts_at = options[:start] || '00:00'
      time = options[:time] || 1
      output_file = options[:output_file] || "#{File.basename(input_file, '.MP4')}_#{starts_at}.mp4"

      execute_ffmpeg_command(
        input_file: input_file,
        output_file: "#{output_path}/#{output_file}",
        raw_options: { output: "-ss #{starts_at} -t #{time}" }
      )
    end

    def copy_metadata(origin, target)
      exif = MiniExiftool.new(target)
      exif.copy_tags_from(origin, '*')
    end

    def copy_metadata_to_screenshots(basename, fps)
      Dir.glob("#{output_path}/#{basename}*.jpg").sort.each do |file|
        seconds = 1.0 / fps * File.basename(file, '.jpg').gsub(basename, '').to_i
        exif = MiniExiftool.new(file)
        exif.create_date = original_date_time + seconds.seconds
        exif.save
      end
    end

    def original_date_time
      exif = MiniExiftool.new(@input_file)
      exif.date_time_original || exif.create_date || exif.modify_date
    end
  end
end
