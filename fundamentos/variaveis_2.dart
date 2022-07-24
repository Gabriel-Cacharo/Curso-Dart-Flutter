main() {
  var n1 = 2;
  var n2 = 4.56;
  var texto = 'O valor da soma é: ';

  print(texto + (n1 + n2).toString());
  print(n1.runtimeType);

  var t1 = "Olá ";
  var t2 = "Dart";

  print (t1 + t2);
  print(t1.runtimeType);

  print(t1 is int);
  print(t1 is String);
}