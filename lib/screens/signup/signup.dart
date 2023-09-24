import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/components/app_button.dart';
import 'package:travelwise/components/app_toast.dart';
import 'package:travelwise/components/pw_form_field.dart';
import 'package:travelwise/components/text_form_field.dart';
import 'package:travelwise/firebase/auth/authentication.dart';
import 'package:travelwise/screens/signin/signin.dart';

class AppSignUp extends StatefulWidget {
  const AppSignUp({super.key});

  @override
  State<AppSignUp> createState() => _AppSignUpState();
}

class _AppSignUpState extends State<AppSignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _cpwController = TextEditingController();
  final TextEditingController _bdayController = TextEditingController();
  bool checked = false;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100))
        .then((value) {
      selectedDate = value!;
      setState(() {
        String formatDate = DateFormat('y-MM-dd').format(selectedDate);
        _bdayController.text = formatDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: appPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text("Create Account", style: appTextHeader1),
              const SizedBox(height: 10),
              const Text("Connect with your friends today!",
                  style: appTextSubHeader),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextFormField(
                      controller: _nameController,
                      fieldName: 'Full Name',
                      hintText: 'Enter your Name',
                      errormsg: 'Can\'t be empty',
                    ),
                    AppTextFormField(
                      controller: _emailController,
                      fieldName: 'Email Address',
                      hintText: 'Enter your email',
                      errormsg: 'Can\'t be empty',
                    ),
                    AppTextFormField(
                      hintText: 'Birthday',
                      controller: _bdayController,
                      readOnly: true,
                      onTap: datePicker,
                      fieldName: 'Birthday',
                    ),
                    AppPwFormField(
                      controller: _pwController,
                      fieldName: 'Password',
                      hintText: 'Enter your password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    AppPwFormField(
                      controller: _cpwController,
                      fieldName: 'Confirm Password',
                      hintText: 'Enter your password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can\'t be empty';
                        } else if (value != _pwController.text) {
                          return 'Incorrect password';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: appFieldPadding,
                      child: Row(
                        children: [
                          Checkbox(
                            value: checked,
                            onChanged: (value) {
                              setState(() {
                                checked = value!;
                              });
                            },
                          ),
                          const Text("I agree to the terms and conditions")
                        ],
                      ),
                    ),
                    AppPrimaryBtn(
                      btnText: 'Sign Up',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AppAuth().register(
                            _emailController.text,
                            _pwController.text,
                            _nameController.text,
                            selectedDate,
                            context,
                          );
                        }
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
                          Text("Or Sign Up With"),
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
                                  color:
                                      const Color.fromARGB(134, 102, 102, 102),
                                ),
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
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AppSignin(),
                                ),
                              );
                            },
                            child: const Text("Sign In"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
