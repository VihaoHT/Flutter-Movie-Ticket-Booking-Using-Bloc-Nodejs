import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/auth/screens/login_screen.dart';
import 'package:movie_booking_app/auth/widgets/custom_textfield.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/core/constants/ultis.dart';

import '../../auth/bloc/auth_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController newpasswordController = TextEditingController();
    final TextEditingController passwordConfirmController =
        TextEditingController();
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthChangePasswordSuccess) {

            showToastSuccess(
              context,
              "Change password succesful! now try to login again",
            );

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ), (route) => false);
          }

          if (state is AuthFailure) {
           showToastFailed(context, state.error);
          }
        },

        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 29, top: 20),
                        child: Image.asset(
                          Constants.backPath,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 80, top: 20),
                      child: const Text(
                        "Change Password",
                        style: TextStyle(
                          color: Constants.colorTitle,
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 33, left: 42),
                      child: const Text(
                        "Old password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    CustomTextField(
                        controller: passwordController,
                        hintText: "Enter your old password")
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 42),
                      child: const Text(
                        "New password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    CustomTextField(
                        controller: newpasswordController,
                        hintText: "Enter your new password")
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 42),
                      child: const Text(
                        "Confirm new password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    CustomTextField(
                        controller: passwordConfirmController,
                        hintText: "Enter confirm new password")
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            ChangePasswordButtonPressed(
                              password: passwordController.text.trim(),
                              newPassword: newpasswordController.text.trim(),
                              passwordConfirm:
                                  passwordConfirmController.text.trim(),
                            ),
                          );
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                  left: 33,
                                ),
                                child: Image.asset(Constants.lockPath)),
                            Container(
                              margin: const EdgeInsets.only(right: 80),
                              child: const Text(
                                'Change Password',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
