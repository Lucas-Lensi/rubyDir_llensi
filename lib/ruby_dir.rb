def check_if_user_gave_input
  abort("RubyDir: wrong input, please : 'rubydir folder_name app_name'") unless ARGV.length == 2
end

def make_global_lib_dir
  Dir.mkdir(ARGV.first)
  Dir.mkdir("#{ARGV.first}/lib")
end

def make_gemfile
 gemfile = File.open("#{ARGV.first}/Gemfile", "a")
 gemfile.puts("source 'https://rubygems.org'")
 gemfile.puts("ruby '2.5.1'")
 gemfile.puts("gem 'rubocop', '~> 0.57.2'")
 gemfile.puts("gem 'rspec'")
 gemfile.puts("gem 'pry'")
 gemfile.puts("gem 'nokogiri'")
 gemfile.puts("gem 'launchy'")
 gemfile.puts("gem 'watir'")
 gemfile.close
end

def make_env_and_gitignore
  env = File.open("#{ARGV.first}/.env", "w")
  env.close
  gitignore = File.open("#{ARGV.first}/.gitignore", "a")
  gitignore.puts(".env")
  gitignore.close
end

def make_rb_and_spec
  prog = File.open("#{ARGV.first}/lib/#{ARGV[1]}.rb", "w")
  prog.close
  spec = File.open("#{ARGV.first}/spec/#{ARGV[1]}_spec.rb", "a")
  spec.puts("require_relative '../lib/#{ARGV[1]}'")
  spec.close
end

def make_readme
  rdme = File.open("#{ARGV.first}/README.md", "a")
  rdme.puts("It's a Ruby prog")
  rdme.close
end

def connect_to_git
  system("cd #{ARGV.first} && git init")
  system("cd #{ARGV.first} && rspec --init")
  system("cd #{ARGV.first} && bundle install")
end

def perform
  check_if_user_gave_input
  make_global_lib_dir
  make_gemfile
  make_env_and_gitignore
  make_readme
  connect_to_git
  make_rb_and_spec
end

perform
