# Set path to ImageMagick installation when using Tddium
if ENV.member?('TDDIUM')
  Paperclip.options[:command_path] = "/usr/bin"
end
