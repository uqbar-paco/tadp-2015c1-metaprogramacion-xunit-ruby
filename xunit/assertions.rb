module Assertions
  def assert_true(value)
    unless (value == true)
      raise AssertionException
    end
  end

  def assert_false(value)
    self.assert_true !value
  end

  def assert_equals(expected, value)
    self.assert_true (expected == value)
  end
end