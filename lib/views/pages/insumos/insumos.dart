import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/constants.dart';
import 'package:gestor_empreendimento/controllers/insumo_controller.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_actions.dart';
import 'package:gestor_empreendimento/views/widgets/list_app.dart';
import 'package:gestor_empreendimento/views/widgets/text_field_app.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_user.dart';

class Insumos extends StatefulWidget {
  const Insumos({super.key});

  @override
  State<Insumos> createState() => _InsumosState();
}

class _InsumosState extends State<Insumos> {
  final TextEditingController nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBarUser(),
      body: AppBarActions(
        onBack: () => GoRouter.of(context).pop(),
        onMore: () {},
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Title(
              color: Colors.black,
              child: const Text(
                'Insumos',
                style: TextStyle(fontSize: 36, color: UserColor.primary),
              ),
            ),
          ),
          TextFieldApp(
            textController: nomeController,
            hintText: 'Buscar insumo',
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            onChanged: (_) => setState(() {}),
          ),
          Expanded(
            child: Consumer<InsumoController>(
              builder: (context, controller, _) {
                final insumosFiltrados = controller.filtrarPorNome(
                  nomeController.text,
                );

                return Column(
                  children: [
                    insumosFiltrados.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Nenhum insumo encontrado.',
                              style: TextStyle(
                                fontSize: 20,
                                color: UserColor.secondary,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListApp(
                              shrinkWrap: false,
                              children: insumosFiltrados
                                  .map(
                                    (insumo) => ListTile(
                                      title: Text(insumo.nome),
                                      contentPadding: const EdgeInsets.only(left: 16, right: 8),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Add a SizedBox to push icons to the right
                                          SizedBox(width: 3),
                                          IconButton(
                                            icon: Image.asset(
                                              Img.edit,
                                            ),
                                            onPressed: () {
                                              GoRouter.of(context).push('/insumos/edit', extra: insumo);
                                            },
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                              Img.remove
                                            ),
                                            onPressed: () {
                                              
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: !isKeyboardOpen
                          ? ElevatedButton(
                              key: const ValueKey('novo_insumo_btn'),
                              onPressed: () =>
                                  GoRouter.of(context).push('/insumos/add'),
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
                                    'Novo Insumo',
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
                            )
                          : const SizedBox.shrink(),
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
