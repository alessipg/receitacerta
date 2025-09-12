import 'package:gestor_empreendimento/models/produto.dart';

class Mercadoria extends Produto {
  Mercadoria({
    super.id,
    required super.nome,
    required super.custo,
    required super.quantidade,
    required super.medida,
    required super.isDiscreto,
  });
}
