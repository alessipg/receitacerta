import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/medida.dart';
import 'package:gestor_empreendimento/views/widgets/text_field_app.dart';
import 'package:provider/provider.dart';
import 'package:gestor_empreendimento/models/insumo.dart';
import 'package:gestor_empreendimento/controllers/insumo_controller.dart';
import 'package:go_router/go_router.dart';
//text controller

// Tela temporária para adicionar um insumo

class AddInsumo extends StatelessWidget {
  const AddInsumo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    final insumoController = context.watch<InsumoController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Insumo')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldApp(textController: nomeController),
            SizedBox(height: 16), // Espaço entre o campo e o botão
            ElevatedButton(
              onPressed: () {
                if (nomeController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Nome inválido'),
                      content: const Text(
                        'Por favor, informe um nome para o insumo.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return; // Não cria o insumo nem fecha a tela
                }
                insumoController.criar(
                  Insumo(
                    nome: nomeController.text,
                    quantidade: 0,
                    id: null,
                    custo: 20,
                    medida: Medida.kg,
                    isDiscreto: false,
                  ),
                );
                GoRouter.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
