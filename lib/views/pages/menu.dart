import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/constants.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_actions.dart';
import 'package:go_router/go_router.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_user.dart';
class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(),
      body: AppBarActions(
        onBack: () => GoRouter.of(context).pop(),
        onMore: () {
          // Handle more options
        },
        children: [
          SizedBox(height: 32),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () => GoRouter.of(context).push('/receitas'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(Img.recipeBook),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text('Receitas'),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () => GoRouter.of(context).push('/mercadorias'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(Img.bread), width: 24, height: 24),
                  const SizedBox(width: 8),
                  const Text('Mercadorias'),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () => GoRouter.of(context).push('/insumos'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(Img.wheat), width: 24, height: 24),
                  const SizedBox(width: 8),
                  const Text('Insumos'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
