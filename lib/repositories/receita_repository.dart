import 'package:gestor_empreendimento/models/receita.dart';
import 'package:gestor_empreendimento/models/insumo.dart';
import 'package:gestor_empreendimento/models/mercadoria.dart';
import 'package:gestor_empreendimento/config/medida.dart';

class ReceitaRepository {
  List<Receita> receitas = [];

  ReceitaRepository() {
    // receitas para teste
    receitas = [
      Receita(
        id: 1,
        nome: 'Pão',
        produto: Mercadoria(
          id: 1,
          nome: 'Pão',
          custo: 0.0,
          venda: 0.0,
          quantidade: 0,
          medida: Medida.un,
          isDiscreto: false,
        ),
        materiaPrima: {
          Insumo(
            id: 1,
            nome: 'Farinha de trigo',
            custo: 15,
            quantidade: 5,
            medida: Medida.kg,
            isDiscreto: false,
          ): 1.0, // 2 kg de farinha
          Insumo(
            id: 2,
            nome: 'Ovo',
            custo: 12,
            quantidade: 12,
            medida: Medida.un,
            isDiscreto: true,
          ): 1.0, // 1 ovo
          Insumo(
            id: 3,
            nome: 'Leite',
            custo: 5,
            quantidade: 1,
            medida: Medida.l,
            isDiscreto: false,
          ): 1.0, // 0.5 litros de leite
        },
        qtdMercadoriaGerada: 2,
      ),
      Receita(
        id: 2,
        nome: 'Bolo',
        produto: Mercadoria(
          id: 2,
          nome: 'Bolo',
          custo: 0.0,
          venda: 0.0,
          quantidade: 0,
          medida: Medida.un,
          isDiscreto: false,
        ),
        materiaPrima: {
          Insumo(
            id: 1,
            nome: 'Farinha de trigo',
            custo: 15,
            quantidade: 5,
            medida: Medida.kg,
            isDiscreto: false,
          ): 2.0, // 2 kg de farinha
          Insumo(
            id: 2,
            nome: 'Ovo',
            custo: 12,
            quantidade: 12,
            medida: Medida.un,
            isDiscreto: true,
          ): 3.0, // 3 ovos
          Insumo(
            id: 3,
            nome: 'Leite',
            custo: 5,
            quantidade: 1,
            medida: Medida.l,
            isDiscreto: false,
          ): 0.5, // 0.5 litros de leite
        },
        qtdMercadoriaGerada: 1,
      ),
    ];
  }
}
