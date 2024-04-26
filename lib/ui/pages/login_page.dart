import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_place_app/core/components/components.dart';
import 'package:flutter_place_app/core/core.dart';
import 'package:flutter_place_app/ui/bloc/login/login_bloc.dart';
import 'package:flutter_place_app/ui/pages/home_page.dart';
import 'package:flutter_place_app/ui/pages/register_page.dart';

import '../../data/model/request/login_request_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpaceHeight(50),
              const Text(
                "Places Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SpaceHeight(100),
              CustomTextField(
                controller: emailController,
                label: 'Email',
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
              ),
              const SpaceHeight(50),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    },
                    loaded: (responseModel) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          final requestModel = LoginRequestModel(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          context.read<LoginBloc>().add(
                                LoginEvent.login(requestModel),
                              );
                        },
                        label: 'Login',
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const SpaceHeight(20),
              Button.outlined(
                onPressed: () {
                  context.pushReplacement(const RegisterPage());
                },
                label: 'Register Now',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
