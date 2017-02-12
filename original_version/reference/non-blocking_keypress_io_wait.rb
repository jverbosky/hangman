require 'io/wait'


begin
  system("stty raw -echo") # turn raw input on
  c = nil
  if $stdin.ready?
    c = $stdin.getc
  end
  c.chr if c
ensure
  system "stty -raw echo" # turn raw input off
end

puts c

# def get_key()
#   begin
#     system("stty raw -echo") # turn raw input on
#     c = nil
#     if $stdin.ready?
#       c = $stdin.getc
#     end
#     c.chr if c
#   ensure
#     system "stty -raw echo" # turn raw input off
#   end
# end

# while true
#   c = get_key
#   #p c
#   #puts "[#{c}]" if c
#   sleep 1
#   #puts "tick"
#   if c == "n"
#     puts "Start new game..."
#   elsif c == "q"
#     puts "Quit game..."
#   elsif c == "\n"
#     puts "Enter..."
#   elsif c != nil
#     puts "Some other key"
#   end
# end

# Console output:
# q
# Quit game...
# Enter...
# n
# Start new game...
# Enter...
# s
# Some other key
# Enter...