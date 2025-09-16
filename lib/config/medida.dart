enum Medida {
  //g('g', 'gramas'),
  kg('kg', 'quilogramas'),
  l('L', 'litros'),
  //ml('ml', 'mililitros'),
  un('un', 'unidades');

  final String sigla;
  final String nome;
  const Medida(this.sigla, this.nome);
}

