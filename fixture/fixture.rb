class TestLogicaSuite

  def test_verdadero_es_verdadero
    assert_true true
  end

  def test_suma_correcta
    assert_equals 2, 1+1
  end

  def test_suma_fallida
    assert_equals 4, 1+1
  end

end