
import 'package:adhikar_acehack4_o/common/widgets/custom_button.dart';
import 'package:adhikar_acehack4_o/common/widgets/custom_textfield.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar_acehack4_o/features/auth/views/login.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
  }

  void onSignup() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstnameController.text,
        lastName: lastnameController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return isLoading
        ? LoadingPage()
        : Scaffold(
            body: loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Pallete.primaryColor,
                    ),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: signUpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Create an account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Let\'s create your account',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'First Name',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextfield(
                              keyboardType: TextInputType.text,
                              controller: firstnameController,
                              obsecureText: false,
                              hintText: 'first name',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Last Name',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextfield(
                              keyboardType: TextInputType.text,
                              controller: lastnameController,
                              obsecureText: false,
                              hintText: 'last name',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Email',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextfield(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              obsecureText: false,
                              hintText: 'email',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Password',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextfield(
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obsecureText: true,
                              hintText: 'password',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              child: RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                  text: 'By signing up you agree to our ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                TextSpan(
                                    text:
                                        'Terms, Privacy Policy and conditions',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline))
                              ])),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () => onSignup(),
                              child: const CustomButton(
                                text: 'Create an account',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return LoginScreen();
                                      }));
                                    },
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
          );
  }
}
