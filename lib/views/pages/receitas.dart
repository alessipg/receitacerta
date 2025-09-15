import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_actions.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_user.dart';
import 'package:gestor_empreendimento/views/widgets/text_field_app.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:gestor_empreendimento/views/widgets/list_app.dart';
import 'package:gestor_empreendimento/config/constants.dart';
import 'package:gestor_empreendimento/controllers/receita_controller.dart';

class Receitas extends StatefulWidget {
  const Receitas({super.key});

  @override
  State<Receitas> createState() => _ReceitasState();
}

class _ReceitasState extends State<Receitas> {
  final TextEditingController nomeController = TextEditingController();
  final FocusNode buscaFocusNode = FocusNode();
  bool campoBuscaFocado = false;

  @override
  void initState() {
    super.initState();
    buscaFocusNode.addListener(() {
      setState(() {
        campoBuscaFocado = buscaFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    buscaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBarUser(),
      body: Column(
        children: [
          AppBarActions(
            onBack: () => GoRouter.of(context).pop(),
            onMore: () {},
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Title(
                  color: Colors.black,
                  child: const Text(
                    'Receitas',
                    style: TextStyle(fontSize: 36, color: UserColor.primary),
                  ),
                ),
              ),
              TextFieldApp(
                textController: nomeController,
                hintText: 'Buscar receita',
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                onChanged: (_) => setState(() {}), // just rebuild when typing
              ),
            ],
          ),
          Expanded(
            child: Consumer<ReceitaController>(
              builder: (context, receitaController, _) {
                final receitasFiltradas = receitaController
                    .filtrarPorNome(nomeController.text);

                return Column(
                  children: [
                    ListApp(
                      shrinkWrap: true,
                      children: receitasFiltradas
                          .map(
                            (receita) => ListTile(
                              title: Text(receita.nome),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Image.asset('assets/images/edit.png'),
                                    onPressed: () {
                                      // Edit action
                                    },
                                  ),
                                  IconButton(
                                    icon: Image.asset('assets/images/remove.png'),
                                    onPressed: () {
                                      // Remove action
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    if (!isKeyboardOpen)
                      ElevatedButton(
                        onPressed: () =>
                            GoRouter.of(context).push('/add_receita'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UserColor.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          alignment: Alignment.center,
                          fixedSize: const Size(210, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Nova Receita',
                              style: TextStyle(
                                fontFamily: Font.aleo,
                                fontSize: 20,
                                color: UserColor.secondaryContainer,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.add_circle_outline,
                              color: UserColor.secondaryContainer,
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
