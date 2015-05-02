class XUnitRunner
  def run_test(klass, sym)
    instancia = klass.new
    instancia.singleton_class.include Assertions


    begin
      if instancia.respond_to? :before
        instancia.before
      end

      if sym.to_s.start_with? 'param_test_'
        parametros = instancia.parametros
        parametros.each do |hash_values|


          instancia.define_singleton_method :method_missing do |symbol, *args|
            value = hash_values[symbol]
            if value.nil?
              super
            end
            value
          end
          instancia.send sym
        end
      else
        instancia.send sym
      end


    rescue AssertionException => e
      return ResultadoFailure.new sym, e
    rescue Exception => e
      return ResultadoError.new sym, e
    end

    ResultadoSuccess.new sym

  end

  def run_all_tests(klass)
    methods = klass.instance_methods(false)
    test_methods = methods.select do |method|
      method.to_s.start_with? 'test_' or
          method.to_s.start_with? 'param_test_'
    end

    resultados = test_methods.collect do |test_method|
      self.run_test(klass, test_method)

    end

    ResultadoSuite.new resultados
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

class ResultadoSuite
  attr_accessor :resultados

  def initialize(resultados)
    self.resultados = resultados
  end

  def errorred_tests
    fallidos = self.resultados.select do |resultado|
      resultado.error?
    end

    self.get_signatures fallidos
  end

  def failed_tests
    fallidos = self.resultados.select do |resultado|
      resultado.failure?
    end

    self.get_signatures fallidos
  end

  def successful_tests
    exitosos = self.resultados.select do |resultado|
      resultado.success?
    end

    self.get_signatures exitosos
  end

  def get_signatures(results)
    results.collect do |fallido|
      fallido.signature
    end
  end

  def all_passed?
    self.failed_tests.empty? and self.errorred_tests.empty?
  end
end

class Resultado

  attr_accessor :exception, :signature

  def initialize(signature, exception=nil)
    self.exception = exception
    self.signature = signature
  end

  def failure?
    false
  end

  def success?
    false
  end

  def error?
    false
  end
end

class ResultadoSuccess < Resultado
  def success?
    true
  end

end

class ResultadoFailure < Resultado

  def failure?
    true
  end
end

class ResultadoError < Resultado
  def error?
    true
  end
end

