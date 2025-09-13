import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_actions.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_user.dart';

class Mercadorias extends StatefulWidget {
  const Mercadorias({super.key});

  @override
  State<Mercadorias> createState() => _MercadoriasState();
}

class _MercadoriasState extends State<Mercadorias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(),
      body: AppBarActions(
        onBack: () => Navigator.of(context).pop(),
        onMore: () {},
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Exemplo: número fixo de itens
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Mercadoria ${index + 1}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
