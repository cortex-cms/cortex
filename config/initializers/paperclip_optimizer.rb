Paperclip::PaperclipOptimizer.default_options = {
  allow_lossy: true,
  skip_missing_workers: true,
  jpegoptim: {
    strip: :all,
    max_quality: 90
  },
  advpng: false,
  gifsicle: false,
  jhead: false,
  jpegrecompress: false,
  jpegtran: false,
  optipng: false,
  pngcrush: false,
  pngout: false,
  pngquant: false,
  svgo: false
}
