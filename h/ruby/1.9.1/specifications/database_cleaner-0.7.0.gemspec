# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{database_cleaner}
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Ben Mabey}]
  s.date = %q{2011-11-12}
  s.description = %q{Strategies for cleaning databases.  Can be used to ensure a clean state for testing.}
  s.email = %q{ben@benmabey.com}
  s.extra_rdoc_files = [%q{LICENSE}, %q{README.textile}, %q{TODO}]
  s.files = [%q{LICENSE}, %q{README.textile}, %q{TODO}]
  s.homepage = %q{http://github.com/bmabey/database_cleaner}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Strategies for cleaning databases.  Can be used to ensure a clean state for testing.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
