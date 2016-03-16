module CutCut
  # Media
  class Media < Base
    attr_reader :output_path

    def initialize(options = {})
      @input = options.delete(:input)
      @output = options.delete(:output)
      @output_path = options.delete(:output_path) || File.dirname(@input)
    end

    def convert(options = {})
      scale = options[:scale]
      speed = "-filter:v \"setpts=#{options[:speed]}*PTS\"" if options[:speed]
      copy_metadata = options[:copy_metadata] || false

      output = options[:output] || @output || File.join(@output_path, '__' + File.basename(@input))
      raw_options = "-movflags +faststart -vf scale=#{scale} -c:v libx264 -crf 20 -preset ultrafast  #{speed}"
      execute_ffmpeg_command(input: @input, output: output, raw_options: { output: raw_options })

      Helpers.copy_metadata(@input, output) if copy_metadata
      output
    end

    def extract_screenshots(options = {})
      fps = options[:fps] || 1
      basename = options[:basename] || File.basename(@input, '.MP4') + '_screenshot'
      copy_metadata = options[:copy_metadata]

      execute_ffmpeg_command(
        input: @input,
        output: "#{output_path}/#{basename}%d.jpg",
        raw_options: { output: "-vf fps=#{fps}" }
      )

      copy_metadata_to_screenshots(basename, fps) if copy_metadata
    end

    def cut(options = {})
      starts_at = options[:start] || '00:00'
      time = options[:time] || 1
      output = options[:output] || "#{File.basename(@input, '.MP4')}_#{starts_at}.mp4"

      execute_ffmpeg_command(
        input: @input,
        output: "#{output_path}/#{output}",
        raw_options: { output: "-ss #{starts_at} -t #{time}" }
      )
    end

    def copy_metadata_to_screenshots(basename, fps)
      Dir.glob("#{output_path}/#{basename}*.jpg").sort.each do |file|
        seconds = 1.0 / fps * File.basename(file, '.jpg').gsub(basename, '').to_i
        exif = MiniExiftool.new(file)
        exif.create_date = original_date_time + seconds.seconds
        exif.save
      end
    end
  end
end
