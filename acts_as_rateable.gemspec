Gem::Specification.new do |s|
  s.name     = "acts_as_rateable"
  s.version  = "2.0.2"
  s.date     = "2020-02-24"
  s.summary  = "Rails plugin providing a rating interface for ActiveRecord models"
  s.email    = "evanstv54@gmail.com"
  s.homepage = "http://github.com/tez123z/acts_as_rateable"
  s.description = "Acts_as_rateable is a rails plugin providing a rating interface for ActiveRecord models."
  s.authors  = ["Ferenc Fekete", "Gabriel Gironda", "Michael Reinsch", "Tom Evans"]
  s.rdoc_options  = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG.rdoc", "MIT-LICENSE"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

