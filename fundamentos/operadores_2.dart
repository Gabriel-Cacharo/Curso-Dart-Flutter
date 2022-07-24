main() {
  // Atribuição
  double a = 1;
  a = a + 3;
  a += 3;
  a *= 3;
  a /= 7;
  a %= 2;

  print(a);

  // Relacionais
  print(3 > 2);
  print(3 >= 2);
  print(3 < 2);
  print(3 <= 2);
  print(3 != 3);
  print(3 == 3);
  print(3 == '3');

  print(2 + 5 > 3 && 7 * 3 == 20 + 1);

  print(5 & 4); // Byte
}