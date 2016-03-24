## Iteration 0 - Workspace

Reek:

    [chris@Christophers-MacBook-Pro evercraft_ruby (master)]$ rake reek
    lib/evercraft.rb -- 1 warning:
      [3]:IrresponsibleModule: Evercraft has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
    1 total warning

Rubocop:

    [[chris@Christophers-MacBook-Pro evercraft_ruby (master)]$ rake rubocop
    Running RuboCop...
    Inspecting 8 files
    C.CWCCCC
    
    Offenses:
    
    evercraft.gemspec:7:24: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.name          = "evercraft"
                           ^^^^^^^^^^^
    evercraft.gemspec:9:25: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.authors       = ["Chris"]
                            ^^^^^^^
    evercraft.gemspec:10:25: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.email         = ["ignatz@gmail.com"]
                            ^^^^^^^^^^^^^^^^^^
    evercraft.gemspec:12:24: C: %q-literals should be delimited by ( and ).
      spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    evercraft.gemspec:12:24: C: Use %q only for strings that contain both single quotes and double quotes.
      spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    evercraft.gemspec:12:81: C: Line is too long. [86/80]
      spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
                                                                                    ^^^^^^
    evercraft.gemspec:13:24: C: %q-literals should be delimited by ( and ).
      spec.description   = %q{TODO: Write a longer description or delete this line.}
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    evercraft.gemspec:13:24: C: Use %q only for strings that contain both single quotes and double quotes.
      spec.description   = %q{TODO: Write a longer description or delete this line.}
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    evercraft.gemspec:21:11: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
        raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    evercraft.gemspec:21:81: C: Line is too long. [83/80]
        raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
                                                                                    ^^^
    evercraft.gemspec:24:81: C: Line is too long. [104/80]
      spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^
    evercraft.gemspec:25:24: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.bindir        = "exe"
                           ^^^^^
    evercraft.gemspec:27:25: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.require_paths = ["lib"]
                            ^^^^^
    evercraft.gemspec:29:35: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.add_development_dependency "bundler", "~> 1.11"
                                      ^^^^^^^^^
    evercraft.gemspec:29:46: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.add_development_dependency "bundler", "~> 1.11"
                                                 ^^^^^^^^^
    evercraft.gemspec:30:35: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.add_development_dependency "rake", "~> 10.0"
                                      ^^^^^^
    evercraft.gemspec:30:43: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
      spec.add_development_dependency "rake", "~> 10.0"
                                              ^^^^^^^^^
    Rakefile:1:9: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
    require "bundler/gem_tasks"
            ^^^^^^^^^^^^^^^^^^^
    bin/console:9:29: W: Unused block argument - target_self. If it's necessary, use _ or _target_self as an argument name to indicate that it won't be used.
    Pry.config.prompt = proc { |target_self, nest_level, pry| "#{pry.config.prompt_name} v.#{Evercraft::VERSION}> " }
                                ^^^^^^^^^^^
    bin/console:9:42: W: Unused block argument - nest_level. If it's necessary, use _ or _nest_level as an argument name to indicate that it won't be used.
    Pry.config.prompt = proc { |target_self, nest_level, pry| "#{pry.config.prompt_name} v.#{Evercraft::VERSION}> " }
                                             ^^^^^^^^^^
    bin/console:9:81: C: Line is too long. [113/80]
    Pry.config.prompt = proc { |target_self, nest_level, pry| "#{pry.config.prompt_name} v.#{Evercraft::VERSION}> " }
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    bin/console:21:1: C: 1 trailing blank lines detected.
    lib/evercraft/version.rb:2:13: C: Freeze mutable objects assigned to constants.
      VERSION = '0.0.0'
                ^^^^^^^
    lib/evercraft.rb:1:9: C: Prefer single-quoted strings when you don't need string interpolation or special symbols.
    require "evercraft/version"
            ^^^^^^^^^^^^^^^^^^^
    test/evercraft/test_version.rb:8:4: C: Final newline missing.
    end
       
    test/test_helper.rb:6:25: C: Final newline missing.
    Minitest::Reporters.use!
                            
    
    8 files inspected, 26 offenses detected
    RuboCop failed!
