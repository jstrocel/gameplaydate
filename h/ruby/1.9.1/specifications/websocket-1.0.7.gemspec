# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{websocket}
  s.version = "1.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Bernard Potocki}]
  s.date = %q{2013-01-27}
  s.description = %q{Universal Ruby library to handle WebSocket protocol}
  s.email = [%q{bernard.potocki@imanel.org}]
  s.homepage = %q{http://github.com/imanel/websocket-ruby}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Universal Ruby library to handle WebSocket protocol}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.11"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.11"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.11"])
  end
end
