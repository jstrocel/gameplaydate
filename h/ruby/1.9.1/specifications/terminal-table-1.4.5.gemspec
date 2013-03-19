# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{terminal-table}
  s.version = "1.4.5"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = [%q{TJ Holowaychuk}, %q{Scott J. Goldman}]
  s.cert_chain = nil
  s.date = %q{2012-03-14}
  s.description = %q{Simple, feature rich ascii table generation library}
  s.email = %q{tj@vision-media.ca}
  s.extra_rdoc_files = [%q{README.rdoc}, %q{lib/terminal-table.rb}, %q{lib/terminal-table/cell.rb}, %q{lib/terminal-table/core_ext.rb}, %q{lib/terminal-table/import.rb}, %q{lib/terminal-table/table.rb}, %q{lib/terminal-table/version.rb}, %q{lib/terminal-table/row.rb}, %q{lib/terminal-table/separator.rb}, %q{lib/terminal-table/style.rb}, %q{lib/terminal-table/table_helper.rb}, %q{tasks/docs.rake}, %q{tasks/gemspec.rake}, %q{tasks/spec.rake}]
  s.files = [%q{README.rdoc}, %q{lib/terminal-table.rb}, %q{lib/terminal-table/cell.rb}, %q{lib/terminal-table/core_ext.rb}, %q{lib/terminal-table/import.rb}, %q{lib/terminal-table/table.rb}, %q{lib/terminal-table/version.rb}, %q{lib/terminal-table/row.rb}, %q{lib/terminal-table/separator.rb}, %q{lib/terminal-table/style.rb}, %q{lib/terminal-table/table_helper.rb}, %q{tasks/docs.rake}, %q{tasks/gemspec.rake}, %q{tasks/spec.rake}]
  s.homepage = %q{http://github.com/visionmedia/terminal-table}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Terminal-table}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{terminal-table}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Simple, feature rich ascii table generation library}

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
