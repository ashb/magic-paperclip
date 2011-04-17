# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "paperclip-filemagic/version"

Gem::Specification.new do |s|
  s.name        = "paperclip-filemagic"
  s.version     = Paperclip::Filemagic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ash Berlin"]
  s.email       = ["ash.berlin@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Filemagic based mimetype detection for Paperclip}
  s.description = %q{Adds better file type detection support into Thoughtbot's Paperclip}

  #s.rubyforge_project = "paperclip-filemagic"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'ruby-filemagic'
  s.add_dependency 'paperclip'

  s.add_development_dependency 'mocha'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'sqlite3-ruby'
end
