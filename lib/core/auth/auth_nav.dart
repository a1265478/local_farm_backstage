import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/core/auth/auth_bloc.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/modules/dashboard/dashboard.dart';
import 'package:local_farm_backstage/modules/login/login_page.dart';

class AuthNav extends StatelessWidget {
  const AuthNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state.status != Status.success)
              const MaterialPage(child: LoginPage()),
            if (state.status == Status.success)
              const MaterialPage(child: Dashboard()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
