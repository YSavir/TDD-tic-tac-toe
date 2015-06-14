module Iodize
  @@suppressing = false

  def io_channel(&block)
    old_stdout = $stdout
    old_stdin = $stdin

    $stdout = StringIO.new

    yield(Iodize::Channel.new)

    $stdout.rewind
    output = $stdout.readlines

    $stdout = old_stdout
    $stdin = old_stdin
    return output
  end

  def self.toggle_output_suppression
    @@suppressing ? end_suppression : start_suppressing    
  end

  class Channel

    def set_input(*values)
      $stdin = StringIO.new(values.join("\n"))
    end

  end

  def self.suppress_output
    STDOUT.puts "Suppressing all output\n\n"
    @@old_stdout = $stdout
    $stdout = StringIO.new
  end

  def self.allow_output
    $stdout = @@old_stdout
  end
  

end

