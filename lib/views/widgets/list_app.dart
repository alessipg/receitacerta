import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/constants.dart';

class ListApp extends StatelessWidget {
  const ListApp({super.key, required this.children, this.shrinkWrap = false});

  final List<Widget> children;
  final bool shrinkWrap;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: children.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.white : UserColor.secondaryContainer,
            border: Border.all(color: UserColor.primary, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: children[index],
        );
      },
    );
  }
}
