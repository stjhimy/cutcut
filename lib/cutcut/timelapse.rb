module CutCut
  # Media
  class Timelapse < Base
    def initialize(options = {})
      @input = options[:input]
      @output = options[:output]
    end

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
      common_substring + "#{start_number.chars.count}%d.JPG"
    end

    def convert(options = {})
      fps = options[:fps] || 30
      execute_ffmpeg_command(
        input_file: input_file,
        output_file: "#{output_path}/out.mp4",
        raw_options: "-f image2  -start_number 036 -framerate #{fps} c:v libx264 -r 30 -pix_fmt yuv420p"
      )
    end
  end
end
