# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'treeview/version'

Gem::Specification.new do |spec|
  spec.name          = "treeview"
  spec.version       = TreeView::VERSION
  spec.authors       = ["mocchi"]
  spec.email         = ["boom.boom.planet@gmail.com"]
  spec.summary       = %q{tree view command && lib}
  spec.description   = %q{tree view command && lib}
  spec.homepage      = "https://github.com/mocchit/treeview"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
