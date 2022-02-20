import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/core/auth/auth_bloc.dart';
import 'package:local_farm_backstage/core/enumKey.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.green, width: 3),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onChanged: (value) => BlocProvider.of<AuthBloc>(context)
                        .add(ChangeAccount(account: value)),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.account_box),
                      labelText: "帳號",
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => BlocProvider.of<AuthBloc>(context)
                        .add(ChangePassword(password: value)),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "密碼",
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state.status == Status.working) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10)),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(Login());
                          },
                          child: const Text("登入"),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Text(
                        state.errorMsg,
                        style: const TextStyle(color: Colors.red),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
