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
    required this.id,
    required this.nome,
    required materiaPrima,
    required this.produto,
    required qtdMercadoriaGerada,
  }) {
    materiaPrima.forEach((insumo, qtdInsumo) {
      consumoPorUnidade[insumo] = qtdInsumo / qtdMercadoriaGerada;
    });
    custoUnitario = _calcularCusto(consumoPorUnidade);
  }

  static double _calcularCusto(Map<Insumo, double> consumoPorUnidade) {
    double custoTotal = 0.0;
    consumoPorUnidade.forEach((insumo, quantidadePorUnidade) {
      custoTotal += insumo.custo * quantidadePorUnidade;
    });
    return custoTotal;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'produto': produto.toJson(),
    'custoUnitario': custoUnitario,
    'consumoPorUnidade': consumoPorUnidade.map(
      (insumo, quantidade) => MapEntry(insumo.id.toString(), quantidade),
    ),
  };
}
