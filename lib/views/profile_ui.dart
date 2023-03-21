import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfileUI extends StatefulWidget {
  const ProfileUI({super.key});

  @override
  State<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
    );
  }
}