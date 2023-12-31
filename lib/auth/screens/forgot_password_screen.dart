import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';
import 'package:movie_booking_app/auth/bloc/auth_bloc.dart';

import '../../core/constants/constants.dart';
import '../widgets/custom_textfield.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffFA6900), Color(0xffDA004E)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200, 70.0));

    final TextEditingController emailController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }

            if (state is AuthForgotSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "The link for reset password have been sent to the email!",
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
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(ForgotButtonPressed(
                            email: emailController.text,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xffF34C30), Color(0xffDA004E)]),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: 335,
                        height: 60,
                        alignment: Alignment.center,
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
