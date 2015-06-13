module IOHelpers
  # Allows for presetting a gets input
  # Join multiple strings with a newline so they are gets'ed individually
  def set_input!(*values)
    $stdin = StringIO.new(values.join("\n"))
  end

  def reset_input!
    @stdin = STDIN
  end

  # Allows for inspecting output
  def capture_output!
    $stdout = StringIO.new
  end
  def reset_output!
    $stdout = STDOUT
  end

end
