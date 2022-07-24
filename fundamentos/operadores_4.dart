import 'dart:io';

main() {
  stdout.write('Está chovendo? (s/N) ');
  final resposta1 = stdin.readLineSync();
  bool estaChovendo = resposta1 == "s";

  stdout.write('Está frio? (s/N) ');
  bool estaFrio = stdin.readLineSync() == "s";

  String resultado = estaChovendo && estaFrio ? "Ficar em casa" : "Sair";

  print(resultado);
  print(estaChovendo && estaFrio ? "Azarado!" : "Sortudo!");
}