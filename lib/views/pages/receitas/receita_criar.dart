import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_actions.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_user.dart';
import 'package:gestor_empreendimento/views/widgets/text_field_app.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:gestor_empreendimento/config/constants.dart';
class ReceitaCriar extends StatefulWidget {
  const ReceitaCriar({super.key});

  @override
  State<ReceitaCriar> createState() => _ReceitaCriarState();
}

class _ReceitaCriarState extends State<ReceitaCriar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarUser(), body: AppBarActions(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Criar Receita',
                style: TextStyle(fontSize: 24, color: UserColor.primary),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    ));
  }
}
