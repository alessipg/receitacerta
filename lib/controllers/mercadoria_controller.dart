import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/medida.dart';
import 'package:gestor_empreendimento/controllers/receita_controller.dart';
import 'package:gestor_empreendimento/models/mercadoria.dart';
import 'package:gestor_empreendimento/repositories/mercadoria_repository.dart';
import 'dart:collection';

class MercadoriaController extends ChangeNotifier {
  final MercadoriaRepository repository;

  int _idCounter = 0;

  MercadoriaController(this.repository) {
    // 🔹 Garante IDs únicos para mercadorias já existentes
    for (final mercadoria in repository.mercadorias) {
      if (mercadoria.id == null) {
        mercadoria.id = _idCounter++;
      } else if (mercadoria.id! >= _idCounter) {
        _idCounter = mercadoria.id! + 1;
      }
    }
  }

  UnmodifiableListView<Mercadoria> get mercadorias =>
      UnmodifiableListView(repository.mercadorias);

  List<double> getCustos(String nome, ReceitaController receitaController) {
    final receitas = receitaController.receitas
        .where((r) => r.produto.nome == nome) // filtra
        .map((r) => r.custoUnitario) // pega apenas o custo
        .toList(); // transforma em lista

    if (receitas.isEmpty) {
      return [0.0];
    }

    return receitas;
  }

  double menorCusto(String nome, ReceitaController receitaController) {
    final custos = getCustos(nome, receitaController);
    if (custos.isEmpty) {
      return 0.0;
    }
    final menor = custos.reduce((a, b) => a < b ? a : b);
    return menor;
  }

  void criar(
    String nome,
    double venda,
    double quantidade,
    Medida medida,
    ReceitaController receitaController,
  ) {
    if (repository.mercadorias.any((element) => element.nome == nome)) {
      throw Exception('Mercadoria com nome ${nome} já existe.');
    }
    final menor = menorCusto(nome, receitaController);

    final mercadoria = Mercadoria(
      nome: nome,
      venda: venda,
      custo: menor,
      id: null,
      quantidade: quantidade,
      medida: medida,
      isDiscreto: false,
    );

    mercadoria.id = _idCounter++;
    // 🔹 ID vem só do controller
    repository.mercadorias.add(mercadoria);
    notifyListeners();
  }

  List<Mercadoria> getAll() => List.unmodifiable(repository.mercadorias);

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

  List<String> getNomesMercadorias() {
    return mercadorias.map((mercadoria) => mercadoria.nome).toList();
  }
}
