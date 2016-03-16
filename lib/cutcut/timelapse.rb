module CutCut
  # Media
  class Timelapse < Base
    def files
      Dir.glob(File.join(input, '*.JPG'))
    end

    def basenames
      files.map { |e| File.basename(e, '.JPG').to_s }
    end

    def common_substring
      Helpers.longest_common_substring(*basenames)
    end

    def start_number
      basenames.first.gsub(common_substring, '')
    end

    def input_basename
      common_substring + "%#{start_number.chars.count}d.JPG"
    end

    def convert(options = {})
      fps = options[:fps] || 30
      execute_ffmpeg_command(
        input: File.join(@input, input_basename),
        output: @output,
        raw_options: {
          input: "-f image2  -start_number #{start_number} -framerate #{fps}",
          output: '-c:v libx264 -r 30 -vf scale=-1:1080 -crf 23 -preset ultrafast -pix_fmt yuv420p'
        }
      )
      @output
    end
  end
end
