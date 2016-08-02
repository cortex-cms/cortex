Paperclip::PaperclipOptimizer.default_options = {
  allow_lossy: true,
  skip_missing_workers: true,
  jpegoptim: {
    allow_lossy: true,
    strip: :all,
    max_quality: 60
  },
  advpng: false,
  gifsicle: {
    interlace: true
  },
  jhead: false,
  jpegrecompress: false,
  jpegtran: false,
  optipng: false,
  pngcrush: false,
  pngout: false,
  pngquant: {
    allow_lossy: true,
    quality: !ruby/range 33..50,
    speed: 3
  },
  svgo: false
}
