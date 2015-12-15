Gem::Specification.new do |s|
  s.name        = 'music_today_api_wrapper'
  s.version     = '16.12.15.01'
  s.date        = '2015-12-16'
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

  s.add_dependency 'bundler', '>= 1.10.6'
  s.add_dependency 'rake', '>= 10.4.2'
  s.add_dependency 'json', '~> 1.8', '>= 1.8.3'
end
