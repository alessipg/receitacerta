import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_actions.dart';
import 'package:gestor_empreendimento/views/widgets/app_bar_user.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;

  const CustomScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // padrão já é true
      appBar: AppBarUser(),
      body: SafeArea(
        child: Column(
          children: [
            AppBarActions(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
