import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/components/app_button.dart';
import 'package:travelwise/components/app_toast.dart';
import 'package:travelwise/components/appbar/appbar_back.dart';
import 'package:travelwise/components/modern_inputfiled.dart';
import 'package:travelwise/firebase/user_basic.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map<String, dynamic> userData = {};
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _bDay = TextEditingController();
  final TextEditingController _pnNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();
  DateTime? initDate;
  String? selectedItem;
  List<String> gendertype = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();

    getUserData().then((data) {
      setState(() {
        userData = data;
        String formatDate =
            DateFormat('y-MM-dd').format(data['birthDay'].toDate());
        initDate = data['birthDay'].toDate();
        _fullname.text = data['fullname'].toString();
        _address.text = data['address'].toString();
        selectedItem = data['gender'].toString();
        _bDay.text = formatDate;
        _pnNumber.text = data['phoneNumber'].toString();
        isLoading = false;
      });
    });
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: initDate!,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100))
        .then((value) {
      selectedDate = value!;
      setState(() {
        String formatDate = DateFormat('y-MM-dd').format(selectedDate);
        _bDay.text = formatDate;
      });
    });
  }

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateUserBasic() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'fullname': _fullname.text,
        'gender': selectedItem,
        'birthDay': selectedDate,
        'phoneNumber': int.parse(_pnNumber.text),
        'address': _address.text,
      });
      AppToastmsg.appToastMeassage('Update success');
    } catch (e) {
      if (e is FormatException) {
        AppToastmsg.appToastMeassage(
            '${e.message} (\'${e.source}\' is not a number)');
      } else {
        AppToastmsg.appToastMeassage('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBack(title: 'Edit Profile'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(userData['fullname'].toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        Text(userData['email'].toString(),
                            style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 102, 102, 102))),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Form(
                        child: Column(
                      children: [
                        AppModernTextFormField(
                          hintText: 'Full Name',
                          controller: _fullname,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 199, 199, 199)),
                                  borderRadius: appBorderRadius,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: selectedItem !=null ? selectedItem : 'Male',
                                  items:
                                      gendertype.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectedItem = val;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Gender',
                                    labelText: 'Gender',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 11,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: AppModernTextFormField(
                            //     hintText: 'Gender',
                            //     controller: _gender,
                            //   ),
                            // ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: AppModernTextFormField(
                                hintText: 'Birthday',
                                controller: _bDay,
                                readOnly: true,
                                onTap: datePicker,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        AppModernTextFormField(
                          hintText: 'Phone Number',
                          controller: _pnNumber,
                          texttype: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        AppModernTextFormField(
                          hintText: 'Address',
                          controller: _address,
                        ),
                        const SizedBox(height: 50),
                        AppPrimaryBtn(
                          onPressed: () {
                            updateUserBasic();
                          },
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
