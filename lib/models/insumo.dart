import 'package:gestor_empreendimento/models/produto.dart';

class Insumo extends Produto {

  Insumo({
    super.id,
    required super.nome,
    required super.custo,
    required super.quantidade,
    required super.medida,
    required super.isDiscreto,
  }){
    custo = custo / quantidade;
  }

}
