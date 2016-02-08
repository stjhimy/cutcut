Gem::Specification.new do |s|
  s.name        = 'cutcut'
  s.authors     = ['Jhimy Fernandes Villar']
  s.email       = ['stjhimy@gmail.com']
  s.homepage    = 'http://github.com/stjhimy/cutcut'
  s.license     = 'MIT'
  s.summary     = 'Trim/Cut/Screenshot videos'
  s.description = ''
  s.version     = '0.0.2'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency 'activesupport',               '~> 4.2'
  s.add_dependency 'mini_exiftool',               '~> 2.5'

  s.add_development_dependency 'guard',           '~> 2.13'
  s.add_development_dependency 'guard-rspec',     '~> 4.6'
  s.add_development_dependency 'guard-rubocop',   '~> 1.2'
  s.add_development_dependency 'rspec',           '~> 3.4'
end
