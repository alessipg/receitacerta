import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:gestor_empreendimento/models/mercadoria.dart';
import 'package:gestor_empreendimento/models/insumo.dart';
import 'package:gestor_empreendimento/repositories/receita_repository.dart';
import 'package:gestor_empreendimento/models/receita.dart';
import 'package:gestor_empreendimento/controllers/insumo_controller.dart';
import 'package:diacritic/diacritic.dart';

class ReceitaController extends ChangeNotifier {
  final ReceitaRepository repository;
  final InsumoController insumoController;
  ReceitaController(this.repository, this.insumoController);

  UnmodifiableListView<Receita> get receitas =>
      UnmodifiableListView(repository.receitas);

  void criar(
    String nome,
    Map<Insumo, double> materiaPrima,
    Mercadoria mercadoria,
    var qtdMercadoria,
  ) {
    repository.receitas.add(
      Receita(
        nome: nome,
        produto: mercadoria,
        quantidade: qtdMercadoria,
        materiaPrima: materiaPrima,
      ),
    );
    notifyListeners();
  }

  void produzir(
    Map<Insumo, double> materiaPrima,
    Map<Mercadoria, double> produtos,
    String nome,
  ) {
    bool allOk = true;
    materiaPrima.forEach((insumo, qtd) {
      if (!insumoController.checkQuantidade(insumo.id!, qtd)) {
        allOk = false;
        throw Exception(
          'Quantidade insuficiente de ${insumo.nome} em estoque.',
        );
      }
    });
    if (!allOk) {
      return;
    }
    notifyListeners();
  }

  List<Receita> getAll() {
    return repository.receitas;
  }

  Receita getById(int id) {
    return repository.receitas.firstWhere((receita) => receita.id == id);
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
