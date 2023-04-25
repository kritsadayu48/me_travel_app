// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:me_travel_app/%E0%B8%B5utils/db_helper.dart';
import 'package:me_travel_app/models/user.dart';
import 'package:me_travel_app/views/register_ui.dart';
import 'package:me_travel_app/views/travel_home_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  //สร้างตัวแปร(ตัว Controller) ไว้เก็บค่าจาก TextField
  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');


bool isShowPassword = false;

   showWarningDialog(BuildContext context, String msg) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'คำเตือน',
            style: GoogleFonts.kanit(),
          ),
          content: Text(
            msg,
            style: GoogleFonts.kanit(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: GoogleFonts.kanit(),
              ),
            )
          ],
        );
      },
    );
  }


//สร้างเมธตอด checkSigin เพื่อตรวจสอบ usernam และ password 
checkSigin(BuildContext context) async {
  //ตรวจสอบว่า username และ password มีในฐานข้อมูลหรือไม่
  //โดยจะเก็บผลลัพธ์ไว้ในตัวแปร
  User? user = await DBHelper.signinUser(
    usernameCtrl.text,
    passwordCtrl.text,
  );
  //ถ้าUser เป็น null แสดวงส่า username หรือ password ไม่ถูกต้อง
  if (user == null) {
    //แสดงว่า Dialog เตือน แปลว่า username/password ไม่ถูกต้อง
    showWarningDialog(context, 'username/password ไม่ถูกต้อง');
  } else {
    //แปลว่า  user/password ถูกต้องเปิดไปหน้า TravelHomeUI 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TravelHomeUI(user: user),
      )
    );
  }
}
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: MediaQuery.of(context).size.width * 0.4,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Text(
                'เข้าใช้งานแอปพลิเคชั่น',
                style: GoogleFonts.kanit(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: Colors.blueAccent),
              ),
              Text(
                'บันทึกการเดินทาง',
                style: GoogleFonts.kanit(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                ),
                child: Row(
                  children: [
                    Text(
                      'ชื่อผู้ใช้',
                      style: GoogleFonts.kanit(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                ),
                child: TextField(
                  controller: usernameCtrl,
                  style: GoogleFonts.kanit(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                ),
                child: Row(
                  children: [
                    Text(
                      'รหัสผ่าน',
                      style: GoogleFonts.kanit(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                ),
                child: TextField(
                  controller: passwordCtrl,
                  style: GoogleFonts.kanit(),
                  obscureText: !isShowPassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      icon: isShowPassword == true
                      ? Icon(
                        Icons.visibility,
                        color: Colors.blue,
                      )
                      : Icon(
                        Icons.visibility_off,
                        color:  Colors.blue,
                      )
                      
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              ElevatedButton(
                onPressed: () {
                  if (usernameCtrl.text.isEmpty) {
                    showWarningDialog(context, 'กรุณากรอกชื่อผู้ใช้');
                  }else if (passwordCtrl.text.isEmpty) {
                    showWarningDialog(context, 'กรุณากรอกรหัสผ่าน');
                  }else{
                    checkSigin(context);
                  }
                },
                //validate ค่าที่รับมาจาก TextField ว่าว่างหรือไม่
                child: Text(
                  'SIGN IN',
                  style: GoogleFonts.kanit(),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.width * 0.125,
                  ),
                  backgroundColor: Colors.lightBlue,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (val) {},
                  ),
                  Text(
                    'จำค่าการเข้าใช้งานแอปพลิเคชั่น',
                    style: GoogleFonts.kanit(),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterUI(),
                    ),
                  );
                },
                child: Text(
                  'ลงชื่อเข้าใช้งาน',
                  style: GoogleFonts.kanit(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
