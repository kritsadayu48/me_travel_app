import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:me_travel_app/views/register_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
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
                child: TextField(),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility_off,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              ElevatedButton(
                onPressed: () {},
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
