# cutcut

Trim/Cut/Screenshot videos

# Usage

```
  gem install cutcut git: git@github.com:stjhimy/cutcut.git
```

```ruby
  media = CutCut::Media.new('path_to_file.mp4')
  media.convert(scale: '1280:720')
  media.convert(scale: '1280:720', copy_metadata: true)
  media.extract_screenshots
  media.cut(start: '00:00', time: 10)
```

## License

MIT License. Copyright 2016 Jhimy Fernandes Villar.
