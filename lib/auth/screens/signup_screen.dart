import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/auth/screens/login_screen.dart';
import 'package:movie_booking_app/auth/widgets/custom_textfield.dart';
import 'package:movie_booking_app/core/constants/constants.dart';

import '../bloc/auth_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffFA6900), Color(0xffDA004E)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200, 70.0));

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordConfirmController =
        TextEditingController();
    final TextEditingController usernameController = TextEditingController();

    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }

              if (state is AuthSignUpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Sign up succesfully!",
                    ),
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 32),
                        child: Image.asset(Constants.backPath)),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text(
                            'Beenema',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 26),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 33, left: 42),
                          child: const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        CustomTextField(
                            controller: emailController,
                            hintText: "Enter your email")
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 20, left: 42),
                          child: const Text(
                            "Username",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        CustomTextField(
                            controller: usernameController,
                            hintText: "Enter your username")
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 20, left: 42),
                          child: const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        CustomTextField(
                            controller: passwordController,
                            hintText: "Enter your password")
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 20, left: 42),
                          child: const Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                        CustomTextField(
                            controller: passwordConfirmController,
                            hintText: "Enter your confirm password"),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SignUpButtonPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  passwordConfirm:
                                      passwordConfirmController.text,
                                  username: usernameController.text,
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xffF34C30),
                                  Color(0xffDA004E)
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              width: 335,
                              height: 60,
                              alignment: Alignment.center,
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
