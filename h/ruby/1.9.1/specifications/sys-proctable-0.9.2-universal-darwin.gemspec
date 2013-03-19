# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sys-proctable}
  s.version = "0.9.2"
  s.platform = %q{universal-darwin}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Daniel J. Berger}]
  s.date = %q{2012-10-08}
  s.description = %q{    The sys-proctable library provides an interface for gathering information
    about processes on your system, i.e. the process table. Most major
    platforms are supported and, while different platforms may return
    different information, the external interface is identical across
    platforms.
}
  s.email = %q{djberg96@gmail.com}
  s.extensions = [%q{ext/darwin/extconf.rb}]
  s.extra_rdoc_files = [%q{CHANGES}, %q{README}, %q{MANIFEST}, %q{doc/top.txt}, %q{ext/darwin/sys/proctable.c}]
  s.files = [%q{CHANGES}, %q{README}, %q{MANIFEST}, %q{doc/top.txt}, %q{ext/darwin/sys/proctable.c}, %q{ext/darwin/extconf.rb}]
  s.homepage = %q{http://www.rubyforge.org/projects/sysutils}
  s.licenses = [%q{Artistic 2.0}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{sysutils}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{An interface for providing process table information}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit>, [">= 2.4.0"])
    else
      s.add_dependency(%q<test-unit>, [">= 2.4.0"])
    end
  else
    s.add_dependency(%q<test-unit>, [">= 2.4.0"])
  end
end
