import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_place_app/core/components/components.dart';
import 'package:flutter_place_app/core/core.dart';
import 'package:flutter_place_app/data/model/request/register_request_model.dart';
import 'package:flutter_place_app/ui/bloc/register/register_bloc.dart';
import 'package:flutter_place_app/ui/pages/home_page.dart';
import 'package:flutter_place_app/ui/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
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
                "Places Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SpaceHeight(100),
              CustomTextField(
                controller: nameController,
                label: 'Name',
              ),
              const SpaceHeight(20),
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
              BlocConsumer<RegisterBloc, RegisterState>(
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
                          final requestModel = RegisterRequestModel(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          context.read<RegisterBloc>().add(
                                RegisterEvent.register(requestModel),
                              );
                        },
                        label: 'Register',
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
                  context.pushReplacement(const LoginPage());
                },
                label: 'Login Now',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
