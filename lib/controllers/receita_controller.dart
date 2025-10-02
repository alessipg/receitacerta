import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:gestor_empreendimento/controllers/mercadoria_controller.dart';
import 'package:gestor_empreendimento/models/mercadoria.dart';
import 'package:gestor_empreendimento/models/insumo.dart';
import 'package:gestor_empreendimento/repositories/receita_repository.dart';
import 'package:gestor_empreendimento/models/receita.dart';
import 'package:gestor_empreendimento/controllers/insumo_controller.dart';
import 'package:diacritic/diacritic.dart';

class ReceitaController extends ChangeNotifier {
  final ReceitaRepository repository;
  final InsumoController insumoController;
  final MercadoriaController mercadoriaController;

  int _idCounter = 0;

  ReceitaController(
    this.repository,
    this.insumoController,
    this.mercadoriaController,
  ) {
    // 🔹 Garante que todas as receitas já existentes tenham ID
    for (final receita in repository.receitas) {
      if (receita.id == null) {
        receita.id = _idCounter++;
      } else if (receita.id! >= _idCounter) {
        // 🔹 Atualiza o contador para continuar dos maiores IDs existentes
        _idCounter = receita.id! + 1;
      }
    }
  }

  UnmodifiableListView<Receita> get receitas =>
      UnmodifiableListView(repository.receitas);

  void criar(
    String nome,
    Map<Insumo, double> materiaPrima,
    Mercadoria mercadoria,
    int qtdMercadoria,
  ) {
    final novaReceita = Receita(
      id: _idCounter++, // 🔹 ID só vem do controller
      nome: nome,
      produto: mercadoria,
      qtdMercadoriaGerada: qtdMercadoria,
      materiaPrima: materiaPrima,
    );

    mercadoriaController.update(
      Mercadoria(
        id: mercadoria.id,
        nome: mercadoria.nome,
        venda: mercadoria.venda,
        custo: novaReceita.custoUnitario,
        quantidade: mercadoria.quantidade,
        medida: mercadoria.medida,
        isDiscreto: mercadoria.isDiscreto,
      ),
    );

    repository.receitas.add(novaReceita);
    notifyListeners();
  }

  void update(Receita receita) {
    final index = repository.receitas.indexWhere((r) => r.id == receita.id);
    if (index == -1) {
      throw Exception('Receita com id ${receita.id} não encontrada.');
    }
    repository.receitas[index] = receita;
    notifyListeners();
  }

  void delete(int id) {
    repository.receitas.removeWhere((receita) => receita.id == id);
    notifyListeners();
  }

  Receita getById(int id) {
    return repository.receitas.firstWhere((receita) => receita.id == id);
  }

  List<Receita> getAll() => List.unmodifiable(repository.receitas);

  List<Receita> filtrarPorNome(String termo) {
    return receitas
        .where(
          (r) => removeDiacritics(
            r.nome.toLowerCase(),
          ).contains(removeDiacritics(termo.toLowerCase())),
        )
        .toList();
  }
}
