class XUnitRunner
  def run_test(klass, sym)
    instancia = klass.new
    instancia.singleton_class.include Assertions

    begin
      instancia.send sym
    rescue AssertionException => e
      return false
    end
    true

  end

end

module Assertions
  def assert_true(value)
    unless (value == true)
      raise AssertionException
    end
  end

  def assert_equals(expected, value)
    self.assert_true (expected == value)
  end
end

class AssertionException < Exception
end