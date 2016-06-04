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
      copy_metadata = options[:copy_metadata] || false
      output = options[:output] || @output || File.join(@output_path, '__' + File.basename(@input))

      execute_ffmpeg_command(input: @input, output: output, raw_options: { output: extract_output_raw_options(options) })

      Helpers.copy_metadata(@input, output) if copy_metadata
      output
    end

    def extract_output_raw_options(options = {})
      scale = options[:scale]
      speed = "-filter:v \"setpts=#{options[:speed]}*PTS\"" if options[:speed]
      remove_audio = options[:remove_audio] == true ? '-an' : nil
      crf = options[:crf] || 20
      "-movflags +faststart -vf scale=#{scale} -c:v libx264 -crf #{crf} -preset ultrafast  #{speed} #{remove_audio} #{options[:raw]}"
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
        seconds = screenshot_basename_time(basename, file, fps)
        exif = MiniExiftool.new(file)
        exif.create_date = original_date_time + seconds.seconds
        exif.save
      end
    end

    def screenshot_basename_time(basename, file, fps)
      (1.0 / fps.to_f) * File.basename(file, '.jpg').gsub(basename, '').to_i - (1.0 / fps.to_f)
    end
  end
end
