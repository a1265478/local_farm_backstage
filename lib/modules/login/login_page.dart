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
          Container(
            alignment: Alignment.center,
            child: const Text("Login"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("帳號"),
                    TextFormField(
                      onChanged: (value) => BlocProvider.of<AuthBloc>(context)
                          .add(ChangeAccount(account: value)),
                    ),
                    const Text("密碼"),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) => BlocProvider.of<AuthBloc>(context)
                          .add(ChangePassword(password: value)),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state.status == Status.working) {
                            return const CircularProgressIndicator();
                          }
                          return ElevatedButton(
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
                          style: TextStyle(color: Colors.red),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
