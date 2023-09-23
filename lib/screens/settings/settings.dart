import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/components/settings_item.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

enum SingingCharacter { lafayette, jefferson }

class _AppSettingsState extends State<AppSettings> {
  SingingCharacter? character = SingingCharacter.lafayette;
  int selectedOption = 1;

  setThemeType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeType', selectedOption);
  }

  getThemeType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getInt('themeType')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getThemeType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: appPagePadding,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1518333648466-e7e0bb965e70?w=1280&h=720',
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('Avishka Prabath',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                const Text('avishkaprabath@gmail.com',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 102, 102, 102))),
              ],
            ),
            const SizedBox(height: 20),
            Material(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: appBorderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AppSettingsItem(
                    icon: Icons.account_circle_outlined,
                    name: 'Edit Profile',
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.1,
                          endIndent: 14,
                          indent: 14,
                        ),
                      ),
                    ],
                  ),
                  AppSettingsItem(
                    icon: Icons.light_mode,
                    name: 'App Theme',
                    onPressed: () {
                      themeDialog(context);
                    },
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.1,
                          endIndent: 14,
                          indent: 14,
                        ),
                      ),
                    ],
                  ),
                  AppSettingsItem(
                    icon: Icons.notifications_none,
                    name: 'Notification',
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.1,
                          endIndent: 14,
                          indent: 14,
                        ),
                      ),
                    ],
                  ),
                  AppSettingsItem(
                    icon: Icons.lock_outline,
                    name: 'Change Password',
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Material(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: appBorderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Text("About the application",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  AppSettingsItem(
                      icon: Icons.info_outline, name: 'About the application'),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.1,
                          endIndent: 14,
                          indent: 14,
                        ),
                      ),
                    ],
                  ),
                  AppSettingsItem(
                      icon: Icons.chat_bubble_outline, name: 'Feedback'),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 3),
                  Text("Sign Out", style: TextStyle(color: Colors.red)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget themeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Choose theme',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              content: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: const Text('System default'),
                      leading: Radio(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Light'),
                      leading: Radio(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Dark'),
                      leading: Radio(
                        value: 3,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setThemeType();
                    setState(() {
                      setThemeType();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                )
              ],
            );
          },
        );
      },
    );
    return Container();
  }
}
