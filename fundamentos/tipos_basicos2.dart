main() {
  var aprovados = ['Ana', 'Carlos', 'Daniel', 'Rafael'];
  print(aprovados is List);
  print(aprovados);
  print(aprovados.elementAt(2));
  print(aprovados[1]);
  print(aprovados.length);

  var telefones = {
    'João': '+55 (11) 98765-4321',
    'Maria': '+55 (16) 95713-4146',
    'Pedro': '+55 (21) 95213-6121',
  };

  print(telefones is Map);
  print(telefones);
  print(telefones['Maria']);
  print(telefones.length);
  print(telefones.values);
  print(telefones.keys);
  print(telefones.entries);

  var times = {'Vasco', 'Flamengo', 'Fortaleza', 'Corinthians'};
  print(times is Set);
  times.add('Palmeiras');
  print(times);
  print(times.contains('Palmeiras'));
  print(times.first);
  print(times.last);
}