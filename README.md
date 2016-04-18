# cutcut

Trim/Cut/Screenshot videos

# Usage

```
  gem install cutcut git: git@github.com:stjhimy/cutcut.git
```

```ruby
  media = CutCut::Media.new(input: 'path_to_file.mp4')
  media.convert(scale: '1280:720')
  media.convert(scale: '1280:720', copy_metadata: true)
  media.convert(speed: 2)
  media.extract_screenshots

  timelapse = CutCut::Timelapse.new(input: 'path_to_folder')
  media.convert(scale: '1280:720')
  media.convert(scale: '1280:720', fps: 60)
```

```
cutcut --help
Usage: cutcut [options]
        --convert                    Convert all videos in a folder
        --copy-metadata              Copy original video metadata
        --scale                      SCALE_RESOLUTION
        --timelapse-fps FPS          Timelapse FPS
        --extract-screenshots NUMBER Screenshots per second
```

## License

MIT License. Copyright 2016 Jhimy Fernandes Villar.
