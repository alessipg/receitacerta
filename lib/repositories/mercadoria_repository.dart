import 'package:gestor_empreendimento/models/mercadoria.dart';
import 'package:gestor_empreendimento/config/medida.dart';

class MercadoriaRepository {
  List<Mercadoria> _mercadorias = [];
  List<Mercadoria> get mercadorias => _mercadorias;

  MercadoriaRepository() {
    // Dados fictícios para exemplo
    _mercadorias = [
      Mercadoria(
        id: 1,
        nome: 'Pão francês',
        custo: 1.0,
        venda: 1.5,
        quantidade: 50,
        medida: Medida.un,
        isDiscreto: true,
      ),
      Mercadoria(
        id: 2,
        nome: 'Bolo de chocolate',
        custo: 15.0,
        venda: 10.0,
        quantidade: 20,
        medida: Medida.un,
        isDiscreto: true,
      ),
      Mercadoria(
        id: 3,
        nome: 'Torta de maçã',
        custo: 25.0,
        venda: 40.0,
        quantidade: 10,
        medida: Medida.un,
        isDiscreto: true,
      ),
    ];
  }
}
