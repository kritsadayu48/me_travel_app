import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TravelRecordUI extends StatefulWidget {
  const TravelRecordUI({super.key});

  @override
  State<TravelRecordUI> createState() => _TravelRecordUIState();
}

class _TravelRecordUIState extends State<TravelRecordUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
    );
  }
}