import 'dart:io';

main() {
  // Área da circunferência = PI * raio * raio

  const PI = 3.1415;

  stdout.write('Informe o raio: ');
  final entradaUsuario = stdin.readLineSync()!;
  final double raio = double.parse(entradaUsuario);

  final double area = PI * raio * raio;

  print("O valor da área é: " + area.toString());

  // const = não será lido apenas em runtime, já será declarado na aplicação ( compilação )
  // final = runtime
}