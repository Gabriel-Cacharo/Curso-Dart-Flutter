main() {
  // Aritméticos
  int a = 7;
  int b = 5;

  int resultado = a + b;
  print(resultado);
  print(a - b);
  print(a + b);
  print(a * b);
  print(a / b);
  print(a % b);
  print(a + b * a - b);

  // Lógicos
  bool produtoFragil = true;
  bool produtoCaro = false;

  print(produtoFragil && produtoCaro);
  print(produtoFragil || produtoCaro);
  print(produtoFragil ^ produtoCaro); // Apenas 1 dos dois é verdadeiro
  print(!produtoFragil);
  print(!!produtoCaro);
}