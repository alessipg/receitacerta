import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/controllers/receita_controller.dart';
import 'package:gestor_empreendimento/models/receita.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:gestor_empreendimento/config/constants.dart';

class ReceitaEditar extends StatefulWidget {
  final Receita receita;

  const ReceitaEditar({super.key, required this.receita});

  @override
  State<ReceitaEditar> createState() => _ReceitaEditarState();
}

class _ReceitaEditarState extends State<ReceitaEditar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.receita.nome;
  }

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final receita = widget.receita;

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: [
          // Título
          Center(
            child: Text(
              'Receita de ${receita.nome}',
              style: TextStyle(
                fontSize: 24,
                color: UserColor.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nome da receita (único campo editável)
          TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome da receita',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Mercadoria (somente leitura)
          TextFormField(
            initialValue: receita.produto.nome,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Mercadoria gerada',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color.fromARGB(255, 220, 206, 183),
            ),
          ),
          const SizedBox(height: 20),

          // Lista de insumos (somente leitura)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Insumos da receita:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...receita.consumoPorUnidade.entries.map((entry) {
                final insumo = entry.key;
                final quantidade = entry.value;
                return ListTile(
                  title: Text(
                    "$quantidade ${insumo.medida.sigla} de ${insumo.nome}",
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 20),

          // Botão salvar (apenas nome é atualizado)
          Consumer<ReceitaController>(
            builder: (context, receitaController, _) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final receitaAtualizada = Receita(
                      id: receita.id,
                      nome: nomeController.text,
                      materiaPrima: receita.consumoPorUnidade,
                      produto: receita.produto,
                      qtdMercadoriaGerada: 1, // valor já usado no construtor
                    );

                    receitaController.update(receitaAtualizada);

                    FocusScope.of(context).unfocus();
                    GoRouter.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UserColor.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Salvar Alterações',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
