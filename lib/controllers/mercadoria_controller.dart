import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/models/mercadoria.dart';
import 'package:gestor_empreendimento/repositories/mercadoria_repository.dart';
import 'dart:collection';

class MercadoriaController extends ChangeNotifier {
  MercadoriaRepository repository;
  MercadoriaController(this.repository);
  UnmodifiableListView<Mercadoria> get mercadorias =>
      UnmodifiableListView(repository.mercadorias);

  void criar(Mercadoria mercadoria) {
    if (repository.mercadorias.any(
      (element) => element.nome == mercadoria.nome,
    )) {
      throw Exception('Mercadoria com nome ${mercadoria.nome} já existe.');
    }
    repository.mercadorias.add(mercadoria);
    notifyListeners();
  }

  List<Mercadoria> getAll() {
    return repository.mercadorias;
  }

  Mercadoria getById(int id) {
    return repository.mercadorias.firstWhere(
      (mercadoria) => mercadoria.id == id,
    );
  }

  void update(Mercadoria mercadoria) {
    final index = repository.mercadorias.indexWhere(
      (i) => i.id == mercadoria.id,
    );
    if (index == -1) {
      throw Exception('Mercadoria com id ${mercadoria.id} não encontrado.');
    }
    repository.mercadorias[index] = mercadoria;
    notifyListeners();
  }

  void delete(int id) {
    repository.mercadorias.removeWhere((mercadoria) => mercadoria.id == id);
    notifyListeners();
  }

  List<Mercadoria> filtrarPorNome(String termo) {
    return mercadorias
        .where(
          (r) => removeDiacritics(
            r.nome.toLowerCase(),
          ).contains(removeDiacritics(termo.toLowerCase())),
        )
        .toList();
  }
}
