import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/constants.dart';
import 'package:gestor_empreendimento/controllers/mercadoria_controller.dart';
import 'package:gestor_empreendimento/views/widgets/list_app.dart';
import 'package:gestor_empreendimento/views/widgets/text_field_app.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Mercadorias extends StatefulWidget {
  const Mercadorias({super.key});

  @override
  State<Mercadorias> createState() => _MercadoriasState();
}

class _MercadoriasState extends State<Mercadorias> {
  final TextEditingController nomeController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Mercadorias',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              color: UserColor.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFieldApp(
          textController: nomeController,
          hintText: 'Buscar mercadoria',
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          onChanged: (_) => setState(() {}),
        ),
        Consumer<MercadoriaController>(
          builder: (context, controller, _) {
            final mercadoriaFiltradas = controller.filtrarPorNome(
              nomeController.text,
            );
            if (mercadoriaFiltradas.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhuma mercadoria encontrado.',
                  style: TextStyle(fontSize: 20, color: UserColor.secondary),
                ),
              );
            }
            return Column(
              children: [
                ListApp(
                  children: mercadoriaFiltradas
                      .map(
                        (mercadoria) => ListTile(
                          title: Text(mercadoria.nome),
                          contentPadding: const EdgeInsets.only(
                            left: 16,
                            right: 8,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Image.asset(Img.edit),
                                onPressed: () {
                                  GoRouter.of(context).push(
                                    '/mercadorias/edit',
                                    extra: mercadoria,
                                  );
                                },
                              ),
                              IconButton(
                                icon: Image.asset(Img.remove),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
