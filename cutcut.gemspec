Gem::Specification.new do |s|
  s.name        = 'cutcut'
  s.authors     = ['Jhimy Fernandes Villar']
  s.email       = ['stjhimy@gmail.com']
  s.homepage    = 'http://github.com/stjhimy/cutcut'
  s.license     = 'MIT'
  s.summary     = 'Easily Trim/Cut/Screenshot videos'
  s.description = 'CLI for working with videos'
  s.version     = '1.4.6'

  s.executables   = ['cutcut']
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency 'activesupport',               '>= 4.2'
  s.add_dependency 'mini_exiftool',               '~> 2.8'
  s.add_dependency 'ruby-progressbar',            '~> 1.8.1'

  s.add_development_dependency 'guard',           '~> 2.14'
  s.add_development_dependency 'guard-rspec',     '~> 4.7'
  s.add_development_dependency 'rubocop',         '~> 0.4'
  s.add_development_dependency 'guard-rubocop',   '~> 1.2'
  s.add_development_dependency 'rspec',           '~> 3.5'
end
