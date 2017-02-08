# Per: http://stackoverflow.com/questions/170956/how-can-i-find-which-operating-system-my-ruby-program-is-running-on

if RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/
  puts "Windows"
else
  puts "Not Windows"
end