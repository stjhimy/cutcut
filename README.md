# CutCut

* Trim/Cut/Scale videos
* Change video playback speed
* Extract video screenshots based on an interval
* Create timelapses based on sequential images

## Usage

```
  gem install cutcut
```

```ruby
  media = CutCut::Media.new(input: 'path_to_file.mp4')
  media.convert(scale: '1280:720')
  media.convert(scale: '1280:720', copy_metadata: true)
  media.convert(scale: '1280:720', copy_metadata: true, quality: 25)
  media.convert(speed: 2)
  media.extract_screenshots

  timelapse = CutCut::Timelapse.new(input: 'path_to_folder')
  media.convert(scale: '1280:720')
  media.convert(scale: '1280:720', fps: 60)
```

For usage help:

```bash
cutcut --help
Usage: cutcut [options]
        --convert                    Convert all videos in a folder
        --copy-metadata              Copy original video metadata
        --extract-screenshots NUMBER Screenshots per second
        --input INPUT                Input
        --quality CRF                CRF between 0 and 51, 0 lossless. Default to 20
        --raw                        Raw options
        --remove-audio               Video speed
        --scale SCALE_RESOLUTION     Resolution to scale eg: 1280:720
        --speed NUMBER               Video speed
        --timelapse-fps FPS          Timelapse FPS
```

## License

MIT License. Copyright 2016 Jhimy Fernandes Villar.
