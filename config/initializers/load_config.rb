::AppSettings = Hashr.new(YAML.load_file("#{Rails.root}/config/settings.yml")[Rails.env])
::AppSeeds = Hashr.new(YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env])
