module Iodize

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

  class Channel

    def set_input(*values)
      $stdin = StringIO.new(values.join("\n"))
    end

  end

end

