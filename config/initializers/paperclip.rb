# Set path to ImageMagick installation when using Tddium
if ENV.member?('TDDIUM')
  Paperclip.options[:command_path] = "/usr/bin"
end

module Paperclip
  class HashieMashUploadedFileAdapter < AbstractAdapter
    attr_accessor :original_filename
    def initialize(target)
      @tempfile, @content_type, @size = target.tempfile, target.type, target.tempfile.size
      self.original_filename = target.filename
    end

  end
end

Paperclip.io_adapters.register Paperclip::HashieMashUploadedFileAdapter do |target|
  target.is_a? Hashie::Mash
end
