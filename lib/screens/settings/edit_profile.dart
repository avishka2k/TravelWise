import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/components/app_button.dart';
import 'package:travelwise/components/app_toast.dart';
import 'package:travelwise/components/appbar/appbar_back.dart';
import 'package:travelwise/components/capitalize.dart';
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
  final TextEditingController _bDay = TextEditingController();
  final TextEditingController _pnNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  bool isLoading = true;
  DateTime selectedDate = DateTime.now();
  String? selectedItem;
  List<String> gendertype = ['Male', 'Female'];
  final picker = ImagePicker();
  File? imageFile;
  String? profileUrl;

  @override
  void initState() {
    super.initState();

    getUserData().then((data) {
      setState(() {
        userData = data;
        String formatDate =
            DateFormat('y-MM-dd').format(data['birthDay'].toDate());
        selectedDate = data['birthDay'].toDate();
        _fullname.text = data['fullname'].toString();
        _address.text = data['address'].toString();
        selectedItem = data['gender'].toString();
        _bDay.text = formatDate;
        _pnNumber.text = data['phoneNumber'].toString();
        profileUrl = data['profileUrl'].toString();
        isLoading = false;
      });
    });
  }

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
        _bDay.text = formatDate;
      });
    });
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
                                  child: profileUrl == null || profileUrl == ''
                                      ? (imageFile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.file(
                                                imageFile!,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: const Icon(
                                                Icons.account_circle,
                                                color: AppColors.light,
                                                size: 60,
                                              ),
                                            ))
                                      : (imageFile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.file(
                                                imageFile!,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Image.network(
                                                profileUrl!,
                                                fit: BoxFit.fill,
                                              ),
                                            )),
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
                                    onPressed: () async {
                                      Map<Permission, PermissionStatus>
                                          statuses = await [
                                        Permission.camera,
                                      ].request();
                                      if (statuses[Permission.camera]!
                                          .isGranted) {
                                        // ignore: use_build_context_synchronously
                                        showImagePicker(context);
                                      } else {
                                        AppToastmsg.appToastMeassage('No permission provided');
                                      }
                                    },
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
                          child: Text(
                              capitalizedText(userData['fullname'].toString()),
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
                                  value: selectedItem ?? 'Male',
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
                            updateUserBasic(
                              _fullname.text,
                              selectedItem!,
                              selectedDate,
                              _pnNumber.text,
                              _address.text,
                              imageFile,
                            );
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

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: AppColors.dark,
          activeControlsWidgetColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Image Cropper",
        )
      ],
    );
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }
}
