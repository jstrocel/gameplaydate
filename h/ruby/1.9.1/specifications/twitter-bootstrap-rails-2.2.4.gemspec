# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twitter-bootstrap-rails}
  s.version = "2.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Seyhun Akyurek}]
  s.date = %q{2013-02-17}
  s.description = %q{twitter-bootstrap-rails project integrates Bootstrap CSS toolkit for Rails 3.1 Asset Pipeline}
  s.email = [%q{seyhunak@gmail.com}]
  s.homepage = %q{https://github.com/seyhunak/twitter-bootstrap-rails}
  s.post_install_message = %q{Important: You may need to add a javascript runtime to your Gemfile in order for bootstrap's LESS files to compile to CSS. 

**********************************************

ExecJS supports these runtimes:

therubyracer - Google V8 embedded within Ruby

therubyrhino - Mozilla Rhino embedded within JRuby

Node.js

Apple JavaScriptCore - Included with Mac OS X

Microsoft Windows Script Host (JScript)

**********************************************}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{twitter-bootstrap-rails}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Bootstrap CSS toolkit for Rails 3.1 Asset Pipeline}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<actionpack>, [">= 3.1"])
      s.add_runtime_dependency(%q<execjs>, [">= 0"])
      s.add_development_dependency(%q<rails>, [">= 3.1"])
      s.add_development_dependency(%q<less>, [">= 0"])
      s.add_development_dependency(%q<therubyracer>, ["= 0.11.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<actionpack>, [">= 3.1"])
      s.add_dependency(%q<execjs>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 3.1"])
      s.add_dependency(%q<less>, [">= 0"])
      s.add_dependency(%q<therubyracer>, ["= 0.11.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<actionpack>, [">= 3.1"])
    s.add_dependency(%q<execjs>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 3.1"])
    s.add_dependency(%q<less>, [">= 0"])
    s.add_dependency(%q<therubyracer>, ["= 0.11.1"])
  end
end
