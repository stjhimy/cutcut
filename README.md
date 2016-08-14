[![Build Status](https://travis-ci.org/stjhimy/cutcut.svg?branch=master)](https://travis-ci.org/stjhimy/cutcut)

# cutcut

* Trim/Cut/Scale videos
* Change video playback speed
* Extract video screenshots based on an interval
* Create timelapses based on sequential images

# Usage

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
```
cutcut --help
```

## License

MIT License. Copyright 2016 Jhimy Fernandes Villar.
