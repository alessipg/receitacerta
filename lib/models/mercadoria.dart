import 'package:gestor_empreendimento/models/produto.dart';

class Mercadoria extends Produto {
  final double venda;

  Mercadoria({
    super.id,
    required super.nome,
    required super.custo,
    required this.venda,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Mercadoria && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
