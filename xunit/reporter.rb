require 'colorize'

class BaseReporter
  attr_accessor :registered_reports, :end_time, :beginning_time

  def initialize
    self.reset
  end

  def reset
    self.registered_reports = []
  end

  def log_time(timer_variable)
    self.instance_variable_set timer_variable, Time.now
  end

  def start_timer
    self.log_time :@beginning_time
  end

  def end_timer
    self.log_time :@end_time
  end

  def add_result(result)
    self.registered_reports << result
  end

  def failure(result)
    self.add_result result
  end

  def success(result)
    self.add_result result
  end

  def error(result)
    self.add_result result
  end

  def report_assertions
    self.registered_reports.each do |result|
      result.report
    end
  end

  def get_total_reports
    self.registered_reports.length
  end

  def get_successful_reports
    self.registered_reports.select { |report| report.success? }
  end

  def get_error_reports
    self.registered_reports.select { |report| report.error? }
  end

  def get_failure_reports
    self.registered_reports.select { |report| report.failure? }
  end

  def reportar(resultado_suite)
    resultado_suite.resultados.each do |resultado|
      type = resultado.class.to_s
      type.slice! 'Resultado'
      tipo_resultado = type.downcase.to_sym
      self.send tipo_resultado, resultado
    end
    self.report_assertions
  end

end

class ConsoleReporter < BaseReporter

  def report_assertions
    super
    puts "#{self.get_total_reports} tests,#{self.get_successful_reports.length} tests ran ok, #{self.get_failure_reports.length} failures,#{self.get_error_reports.length} errors.".
             colorize(:color => :blue, :background => :black)
    puts "Finished tests in #{(self.end_time - self.beginning_time)*1000} milliseconds".colorize(:color => :cyan, :background => :black)
    puts "\n"
  end

end