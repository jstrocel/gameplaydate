# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{commonjs}
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Charles Lowell}]
  s.date = %q{2012-04-24}
  s.description = %q{Host CommonJS JavaScript environments in Ruby}
  s.email = [%q{cowboyd@thefrontside.net}]
  s.homepage = %q{http://github.com/cowboyd/commonjs.rb}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Provide access to your Ruby and Operating System runtime via the commonjs API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
