import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';
import 'package:movie_booking_app/auth/widgets/custom_textfield.dart';
import 'package:movie_booking_app/home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffFA6900), Color(0xffDA004E)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200, 70.0));

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }

              if (state is AuthSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              }
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 45),
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
                            "Enter your data",
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
                        margin: const EdgeInsets.only(top: 33, left: 42),
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
                          hintText: "Enter your password"),
                      Container(
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(right: 34),
                        child: const Text(
                          "Forgot password",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffDA004E)),
                        ),
                      ),
                      const SizedBox(height: 160),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LoginButtonPressed(
                              email: emailController.text,
                              password: passwordController.text));
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
                              'Log in',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 57),
                      const Text.rich(TextSpan(
                          text: 'Dont Have Account Yet? ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffDA004E),
                              ),
                            )
                          ])),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
