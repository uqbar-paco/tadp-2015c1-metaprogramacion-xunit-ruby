require 'rspec'
require_relative '../fixture/fixture'
require_relative '../xunit/xunit'

describe 'tests de xunit' do

  it 'Ejecutar solo un test verdadero es verdadero' do
    runner = XUnitRunner.new
    resultado = runner.run_test(TestLogicaSuite,
                                :test_verdadero_es_verdadero)
    expect(resultado.success?).to eq(true)
  end

  it 'Ejecutar solo un tests sumas' do
    runner = XUnitRunner.new
    resultado = runner.run_test(TestLogicaSuite,
                                :test_suma_correcta)
    expect(resultado.success?).to be(true)
  end

  it 'Ejecutar solo un tests sumas' do
    runner = XUnitRunner.new
    resultado = runner.run_test(TestLogicaSuite,
                                :test_suma_fallida)
    expect(resultado.success?).to be(false)
  end

  it 'Ejecutar todos los tests de una clase' do
    runner = XUnitRunner.new
    resultado_suite = runner.run_all_tests(TestLogicaSuite)
    expect(resultado_suite.all_passed?).to be(false)
    expect(resultado_suite.failed_tests).to eq([:test_suma_fallida])
    expect(resultado_suite.successful_tests.size).to eq(2)
  end

  it 'Ejecutar todos los tests de una clase que funciona bien' do
    runner = XUnitRunner.new
    resultado = runner.run_all_tests(TestAndaTodoSuite)
    expect(resultado.all_passed?).to be(true)
  end

  it 'Ejecutar todos los tests de una clase que funciona bien' do
    runner = XUnitRunner.new
    resultado = runner.run_all_tests(TestFallaDivisionSuite)
    expect(resultado.all_passed?).to be(false)
    expect(resultado.errorred_tests).to eq([:test_falla_division])
    expect(resultado.failed_tests).to eq([])
  end

  it 'Ejecutar todos los tests de una clase que fall' do
    runner = XUnitRunner.new
    resultado = runner.run_all_tests(TestFallaTestSuite)
    expect(resultado.all_passed?).to be(false)
    expect(resultado.failed_tests).to eq([:test_falla_suma])
    expect(resultado.errorred_tests).to eq([])
  end

  it 'Ejecutar clase con before' do
    runner = XUnitRunner.new

    resultado = runner.run_all_tests(TestConBefore)
    expect(resultado.errorred_tests.size).to eq(0)
    expect(resultado.all_passed?).to eq(true)
  end

  it 'testear con parametros' do
    runner = XUnitRunner.new
    resultado = runner.run_all_tests(TestSuma)
    expect(resultado.all_passed?).to eq(true)
    expect(resultado.successful_tests).to eq([:param_test_suma_conmutativa])
  end
end