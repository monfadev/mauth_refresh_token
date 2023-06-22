import 'package:flutter/material.dart';
import 'package:mauth_refresh_token/core/utils/globals/extensions.dart';
import 'package:mauth_refresh_token/core/viewmodels/auth/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/globals/navigations.dart';
import '../../constants/app_style.dart';
import '../../routes/route_list.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _etUsername = TextEditingController(text: 'john@mail.com');
  final _etPassword = TextEditingController(text: 'changeme');

  @override
  void dispose() {
    _etUsername.dispose();
    _etPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          TextField(
            decoration: AppStyle.fieldDecoration('Username'),
            controller: _etUsername,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: AppStyle.fieldDecoration('Password'),
            controller: _etPassword,
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 45,
            child: TextButton(
              style: AppStyle.normalButton,
              onPressed: () async {
                await context.read<UserProvider>().login(_etUsername.text, _etPassword.text).showAdaptiveDialog(context);

                if (!mounted) return;

                if (context.read<UserProvider>().userJWT != null) {
                  navigate.pushToReplacement(AppRoute.routeMain);
                }
              },
              child: const Text('Masuk'),
            ),
          ),
        ],
      ),
    );
  }
}
