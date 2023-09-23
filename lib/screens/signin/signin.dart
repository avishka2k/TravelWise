import 'package:flutter/material.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/components/app_button.dart';
import 'package:travelwise/components/pw_form_field.dart';
import 'package:travelwise/components/text_form_field.dart';

class AppSignin extends StatefulWidget {
  const AppSignin({super.key});

  @override
  State<AppSignin> createState() => _AppSigninState();
}

class _AppSigninState extends State<AppSignin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool checked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: appPagePadding,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const Text("Hi, Welcome Back!", style: appTextHeader1),
                      Image.asset(
                        'images/icons/waving-hand-emoj.png',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Hello again, you've been missed!",
                    style: appTextSubHeader,
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormField(
                          controller: _emailController,
                          fieldName: 'Email Address',
                          hintText: 'Enter your email',
                          errormsg: 'Can\'t be empty',
                        ),
                        AppPwFormField(
                          controller: _pwController,
                          fieldName: 'Password',
                          hintText: 'Enter your password',
                        ),
                        Padding(
                          padding: appFieldPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: checked,
                                    onChanged: (value) {
                                      setState(() {
                                        checked = value!;
                                      });
                                    },
                                  ),
                                  const Text("Remember Me")
                                ],
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Forgot Password?"))
                            ],
                          ),
                        ),
                        AppPrimaryBtn(
                          btnText: 'Sign In',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.3,
                                  endIndent: 20,
                                ),
                              ),
                              Text("Or Login With"),
                              Expanded(
                                child: Divider(
                                  thickness: 0.3,
                                  indent: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            134, 102, 102, 102)),
                                    borderRadius: appBorderRadius,
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'images/icons/facebook.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text("Facebook")
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            134, 102, 102, 102)),
                                    borderRadius: appBorderRadius,
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'images/icons/google.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text("Google")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Sign In"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
