module CutCut
  # Media
  class Timelapse
    attr_reader :input

    def initialize(options = {})
      @input = options[:input]
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
