import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/models/insumo.dart';
import 'package:gestor_empreendimento/repositories/insumo_repository.dart';
import 'package:diacritic/diacritic.dart';

class InsumoController extends ChangeNotifier {
  InsumoRepository repository;
  InsumoController(this.repository);

  UnmodifiableListView<Insumo> get insumos =>
      UnmodifiableListView(repository.insumos);

  void criar(Insumo insumo) {
    if (repository.insumos.any((element) => element.nome == insumo.nome)) {
      throw Exception('Insumo com nome ${insumo.nome} já existe.');
    }
    repository.insumos.add(insumo);
    notifyListeners();
  }

  void inserirEstoque(int id, double quantidade, double valor) {
    final insumo = repository.insumos.firstWhere((insumo) => insumo.id == id);
    insumo.quantidade += quantidade;
    // Custo médio ponderado
    insumo.custo =
        ((insumo.custo * insumo.quantidade) +
        (insumo.quantidade * valor) / (insumo.quantidade + quantidade));
    // update repository
    repository.insumos[repository.insumos.indexOf(insumo)] = insumo;
    notifyListeners();
  }

  void extrairEstoque(int id, double quantidade) {
    final insumo = repository.insumos.firstWhere((insumo) => insumo.id == id);
    if (insumo.quantidade < quantidade) {
      throw Exception('Quantidade insuficiente de ${insumo.nome} em estoque.');
    }
    insumo.quantidade -= quantidade;
    // update repository
    repository.insumos[repository.insumos.indexOf(insumo)] = insumo;
    notifyListeners();
  }

  void update(Insumo insumo) {
    final index = repository.insumos.indexWhere((i) => i.id == insumo.id);
    if (index == -1) {
      throw Exception('Insumo com id ${insumo.id} não encontrado.');
    }
    repository.insumos[index] = insumo;
    notifyListeners();
  }

  List<Insumo> getAll() {
    return repository.insumos;
  }

  Insumo getById(int id) {
    return repository.insumos.firstWhere((insumo) => insumo.id == id);
  }

  bool checkQuantidade(int id, double quantidade) {
    //alterar para um método de busca depois que implementar DB
    final insumo = repository.insumos.firstWhere((insumo) => insumo.id == id);
    if (insumo.quantidade >= quantidade) {
      return true;
    } else {
      return false;
    }
  }

  void delete(int id) {
    repository.insumos.removeWhere((insumo) => insumo.id == id);
    notifyListeners();
  }

  List<Insumo> filtrarPorNome(String termo) {
    return insumos
        .where(
          (r) => removeDiacritics(
            r.nome.toLowerCase(),
          ).contains(removeDiacritics(termo.toLowerCase())),
        )
        .toList();
  }

  List<String> getNomesInsumos() {
    return insumos.map((insumo) => insumo.nome).toList();
  }
}
