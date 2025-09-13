import 'package:gestor_empreendimento/models/insumo.dart';
import 'package:gestor_empreendimento/models/mercadoria.dart';

class Receita {
  int? id;
  String nome;
  Mercadoria produto;
  late double custoUnitario;
  late Map<Insumo, double> consumoPorUnidade =
      {}; // chave: insumo, valor: quantidade por unidade
  Receita({
    this.id,
    required this.nome,
    required materiaPrima,
    required this.produto,
    required quantidade,
  }) {
    materiaPrima.forEach((insumo, qtd) {
      consumoPorUnidade[insumo] = qtd / quantidade;
   });
    custoUnitario = _calcularCusto(consumoPorUnidade, quantidade);
  }

  static double _calcularCusto(
    Map<Insumo, double> consumoPorUnidade,
    int quantidade,
  ) {
    double custoTotal = 0.0;
    consumoPorUnidade.forEach((insumo, quantidadePorUnidade) {
      custoTotal += insumo.custo * quantidadePorUnidade;
    });
    return custoTotal;
  }
}
