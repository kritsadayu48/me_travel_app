import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
    );
  }
}