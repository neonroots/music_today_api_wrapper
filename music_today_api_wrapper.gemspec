Gem::Specification.new do |s|
  s.name        = 'music_today_api_wrapper'
  s.version     = '29.03'
  s.date        = '2016-02-11'
  s.summary     = 'Gem to expose music today api endpoints.'
  s.description = 'Gem to expose music today api endpoints.'
  s.authors     = ['Pablo Gonzaga', 'Oscar Siniscalchi']
  s.email       = 'pgonzaga.uy@gmail.com'
  s.files       = Dir.glob("{bin,lib}/**/*")
  s.homepage    = 'https://github.com/neonroots/music_today_api_wrapper'
  s.license       = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.3'
  s.add_development_dependency 'byebug', '~> 8.0'
  s.add_development_dependency 'dotenv', '~> 2.0', '>= 2.0.2'
  s.add_development_dependency 'reek', '~> 3.7', '>= 3.7.1'
  s.add_development_dependency 'rubocop', '~> 0.35.1'
  s.add_development_dependency 'spork', '~> 0.9.2'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 1.22'

  s.add_dependency 'bundler', '~> 1.10', '>= 1.10.6'
  s.add_dependency 'rake', '~> 10.4', '>= 10.4.2'
  s.add_dependency 'json', '~> 1.8', '>= 1.8.3'
  s.add_dependency 'credit_card_validator', '~> 1.2'
end
