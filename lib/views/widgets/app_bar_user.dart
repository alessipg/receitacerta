import 'package:flutter/material.dart';
import 'package:gestor_empreendimento/config/constants.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  const AppBarUser({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: UserColor.colorLogo,
          child: Text(
            '\$',
            style: TextStyle(
              color: UserColor.secondary,
              fontSize: 24,
              fontFamily: Font.annieUseYourTelescope,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: UserColor.colorLogo,
            child: Icon(
              Icons.person_2_sharp,
              color: UserColor.secondary,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
