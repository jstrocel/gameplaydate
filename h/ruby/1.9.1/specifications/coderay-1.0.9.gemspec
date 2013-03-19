# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{coderay}
  s.version = "1.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kornelius Kalnbach}]
  s.date = %q{2013-02-20}
  s.description = %q{Fast and easy syntax highlighting for selected languages, written in Ruby. Comes with RedCloth integration and LOC counter.}
  s.email = [%q{murphy@rubychan.de}]
  s.executables = [%q{coderay}]
  s.extra_rdoc_files = [%q{README_INDEX.rdoc}]
  s.files = [%q{bin/coderay}, %q{README_INDEX.rdoc}]
  s.homepage = %q{http://coderay.rubychan.de}
  s.licenses = [%q{MIT}]
  s.rdoc_options = [%q{-SNw2}, %q{-mREADME_INDEX.rdoc}, %q{-t CodeRay Documentation}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = %q{coderay}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Fast syntax highlighting for selected languages.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
