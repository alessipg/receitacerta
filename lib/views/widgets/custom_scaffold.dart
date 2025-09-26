import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_actions.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_user.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;

  const CustomScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(), 
      body: Column(
        children : [
          AppBarActions(),
          child
        ],
      ));
  }
}
