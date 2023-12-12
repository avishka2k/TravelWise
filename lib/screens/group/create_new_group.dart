import 'package:flutter/material.dart';
import 'package:travelwise/components/appbar/appbar_back.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBack(title: "Create Group"),
      body: Container(),
    );
  }
}
