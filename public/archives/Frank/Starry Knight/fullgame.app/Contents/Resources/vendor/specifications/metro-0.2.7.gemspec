# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "metro"
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Franklin Webber"]
  s.date = "2012-11-21"
  s.description = "    Metro is a 2D Gaming framework built around gosu (game development library).\n    Metro makes it easy to create games by enforcing common conceptual structures\n    and conventions.\n"
  s.email = ["franklin.webber@gmail.com"]
  s.executables = ["metro"]
  s.files = ["bin/metro"]
  s.homepage = "https://github.com/burtlo/metro"
  s.post_install_message = "    ______  ___      _____\n    ___   |/  /_____ __  /_______________\n    __  /|_/ / _  _ \\_  __/__  ___/_  __ \\\n    _  /  / /  /  __// /_  _  /    / /_/ /\n    /_/  /_/   \\___/  \\__/ /_/     \\____/\n\n  Thank you for installing metro 0.2.7 / 2012/11-20.\n  ---------------------------------------------------------------------\n  Changes:\n    \n  * FIX to the new game template\n  * Updated the game template to give more movement to the hero in the first scene\n  * Added the fade-in, fade-out helper to show all the instructions\n  \n\n  ---------------------------------------------------------------------\n"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Metro is a 2D Gaming framework built around gosu (game development library). Metro makes it easy to create games by enforcing common conceptual structures and conventions."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gosu>, ["~> 0.7"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.16.0"])
      s.add_runtime_dependency(%q<i18n>, ["~> 0.6.1"])
      s.add_runtime_dependency(%q<active_support>, ["~> 3.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.11"])
    else
      s.add_dependency(%q<gosu>, ["~> 0.7"])
      s.add_dependency(%q<thor>, ["~> 0.16.0"])
      s.add_dependency(%q<i18n>, ["~> 0.6.1"])
      s.add_dependency(%q<active_support>, ["~> 3.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.11"])
    end
  else
    s.add_dependency(%q<gosu>, ["~> 0.7"])
    s.add_dependency(%q<thor>, ["~> 0.16.0"])
    s.add_dependency(%q<i18n>, ["~> 0.6.1"])
    s.add_dependency(%q<active_support>, ["~> 3.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.11"])
  end
end
