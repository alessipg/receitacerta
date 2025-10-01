import 'package:gestor_empreendimento/models/produto.dart';

class Mercadoria extends Produto {
  Mercadoria({
    super.id,
    required super.nome,
    required super.custo,
    required venda,
    required super.quantidade,
    required super.medida,
    required super.isDiscreto,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'quantidade': quantidade,
    'custo': custo,
    'medida': medida.toString(), // ou medida.index
    'isDiscreto': isDiscreto,
  };
}
