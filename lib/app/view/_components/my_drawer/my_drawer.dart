import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/app/data/data_source/local/local_data_repository.dart';
import 'package:test_app/app/domain/repository/auth_repository.dart';
import 'package:test_app/app/view/login/login_page.dart';
import 'package:test_app/app/view/theme/text_style.dart';
import 'package:test_app/config/service_locator.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const _HeaderDrawer(),
        _item(title: 'Perfíl', icon: Icons.person),
        _item(title: 'Mis Productos', icon: Icons.shopping_bag),
        _item(title: 'Configuraciones', icon: Icons.settings),
        const Divider(),
        _item(
          title: 'Cerrar sesión',
          icon: Icons.logout_rounded,
          onTap: () {
            unawaited(LocalDataRepository().logOut());
            unawaited(getIt.get<AuthRepository>().logOut());
            Navigator.pushNamedAndRemoveUntil(
                context, LoginPage.route, (route) => false);
          },
        ),
      ]),
    );
  }

  Widget _item({
    required String title,
    required IconData icon,
    void Function()? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyle.inputStyle,
      ),
      leading: Icon(icon, size: 35),
      onTap: onTap,
    );
  }
}

class _HeaderDrawer extends StatelessWidget {
  const _HeaderDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue[900]!, Colors.blue[100]!])),
      child: Text(
        LocalDataRepository().userEmail ?? '',
        style: AppTextStyle.h3Style.copyWith(color: Colors.white),
      ),
    );
  }
}
