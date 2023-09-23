import 'package:flutter/material.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/components/app_button.dart';
import 'package:travelwise/components/appbar/appbar_back.dart';
import 'package:travelwise/components/modern_inputfiled.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBack(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: appPagePadding,
          child: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColors.dark,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                2, 2, 2, 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: const Icon(
                                Icons.account_circle,
                                color: AppColors.light,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: AppColors.dark,
                                borderRadius: BorderRadius.circular(40)),
                            child: IconButton(
                              color: AppColors.light,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.photo_camera_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text('Avishka Prabath',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  const Text('avishkaprabath@gmail.com',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 102, 102, 102))),
                ],
              ),
              const SizedBox(height: 30),
              Form(
                  child: Column(
                children: [
                  AppModernTextFormField(hintText: 'Full Name'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: AppModernTextFormField(hintText: 'Gender')),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppModernTextFormField(hintText: 'Birthday'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AppModernTextFormField(hintText: 'Phone Number'),
                  const SizedBox(height: 10),
                  AppModernTextFormField(hintText: 'Address'),
                  const SizedBox(height: 50),
                  AppPrimaryBtn(
                    onPressed: () {},
                    btnText: 'Save',
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
