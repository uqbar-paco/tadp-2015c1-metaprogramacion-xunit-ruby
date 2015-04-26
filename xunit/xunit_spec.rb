require 'rspec'
require_relative '../fixture/fixture'
require_relative '../xunit/xunit'

describe 'tests de xunit' do

  it 'Ejecutar solo un test verdadero es verdadero' do
    runner = XUnitRunner.new
    resultado = runner.run_test(TestLogicaSuite,
                                :test_verdadero_es_verdadero)
    expect(resultado).to be(true)
  end

  it 'Ejecutar solo un tests sumas' do
    runner = XUnitRunner.new
    resultado = runner.run_test(TestLogicaSuite,
                                :test_suma_correcta)
    expect(resultado).to be(true)
  end

  it 'Ejecutar solo un tests sumas' do
    runner = XUnitRunner.new
    resultado = runner.run_test(TestLogicaSuite,
                                :test_suma_fallida)
    expect(resultado).to be(false)
  end


end