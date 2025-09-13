import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/constants.dart';
import 'package:go_router/go_router.dart';

class AppBarActions extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMore;
  final List<Widget>? children; // Novo campo
  const AppBarActions({super.key, this.onBack, this.onMore, this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: UserColor.secondary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: UserColor.secondary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () {
                    // Handle more options button press
                  },
                  icon: Icon(Icons.more_vert, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
          if (children != null)
            ...children!, // Adiciona os filhos abaixo dos botões
        ],
      ),
    );
  }
}
