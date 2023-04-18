// ignore_for_file: prefer_is_empty

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:me_travel_app/%E0%B8%B5utils/db_helper.dart';
import 'package:me_travel_app/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
//สร้างตัวควบคุม TextFiled เพื่อนำไปใช้ในการเขียนโค้ด
  TextEditingController fullnameCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');
  TextEditingController phoneCtrl = TextEditingController(text: '');
  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordtrl = TextEditingController(text: '');

//สร้างตัวแปรควบคุมรหัสผ่าน
  bool passwordShowFlag = true;

//สร้างตัวแปรเพื่ออ้างอิงกับรูปที่มาจาก Gallery/Camera เพื่อแสดงที่หน้าจอ
  File? imgFile;

  //สร้างตัวแปรเก็บตำแหน่งรูปถ่าย/เลือก เผื่อจะเก็บใน Database: Sqlite
  String? pictureDir = '';

//สร้างเมธอดเปิด Gallery
  selectImageFromeGallery() async {
    //เลือกรูปจาก Gallery
    XFile? img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (img == null) return; // กรณีเปิด Gallery แล้วไม่เลือกให้ยกเลิก

    //จะเปลี่ยนชื่อรูปและนำรูปไปวไ้ใน ไดเรคทอรี่ของแอป
    Directory directory = await getApplicationDocumentsDirectory();
    String newFileDir = directory.path + Uuid().v4();
    pictureDir = newFileDir; //กำหนดที่อยู่รูปให้กับตัวแปรที้่สร้างไว้ Database

    //แสดงรูปที่หน้าจอ

    File imgFileNew = File(newFileDir);
    await imgFileNew.writeAsBytes(File(img.path).readAsBytesSync());
    setState(() {
      imgFile = imgFileNew;
    });
  }

//สร้างเมธตอดเปิด Camera
  selectImageFromeCamera() async {
    //เลือกรูปจาก Camera
    XFile? img = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (img == null) return; // กรณีเปิด Gallery แล้วไม่เลือกให้ยกเลิก

    //จะเปลี่ยนชื่อรูปและนำรูปไปวไ้ใน ไดเรคทอรี่ของแอป
    Directory directory = await getApplicationDocumentsDirectory();
    String newFileDir = directory.path + Uuid().v4();
    pictureDir = newFileDir; //กำหนดที่อยู่รูปให้กับตัวแปรที้่สร้างไว้ Database

    //แสดงรูปที่หน้าจอ

    File imgFileNew = File(newFileDir);
    await imgFileNew.writeAsBytes(File(img.path).readAsBytesSync());
    setState(() {
      imgFile = imgFileNew;
    });
  }

//สร้างเมธตอดแสดง Dialog เป็นข้อความเตือน
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

  Future showCompreateDialog(BuildContext context, String msg) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'ผลการทำงาน',
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


  //สร้างเมธตอดบันทึกข้อมูล User 
  saveUserToDB(context) async{
    int id = await DBHelper.createUser(
      User(
        fullname: fullnameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        username: usernameCtrl.text.trim(),
        password: passwordtrl.text.trim(),
        picture: pictureDir,
      ),
    );

    if(id !=0) {
      showCompreateDialog(context, 'บันทึกข้อมูลเรียบร้อยแล้ว').then((value) => 
      Navigator.pop(context),
      );
    }else{
      showCompreateDialog(context, 'มีข้อผิดพลาดเกิดขึ้นในการบันทึกข้อมูล');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'ลงทะเบียนเข้าใช้งาน',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imgFile == null
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          backgroundImage: FileImage(
                            imgFile!,
                          ),
                        ),
                  IconButton(
                    onPressed: () {
                      //แสดงเป็ด ModalButtom  ให้ผู้ใช้เลือกว่าจะเป็น Gallery หรือ camera
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  //ถ่ายรูปจาก Cemera
                                  selectImageFromeCamera();
                                  //เมื่อเสร็จแล้วปิด Modal
                                  Navigator.pop(context);
                                },
                                leading: Icon(FontAwesomeIcons.camera),
                                title: Text(
                                  'ถ่ายรูป',
                                  style: GoogleFonts.kanit(),
                                ),
                              ),
                              Divider(),
                              ListTile(
                                onTap: () {
                                  //เลือกรูปจาก Gallery
                                  selectImageFromeGallery();
                                  //เมื่อเสร็จแล้วปิด Modal
                                  Navigator.pop(context);
                                },
                                leading: Icon(Icons.camera),
                                title: Text(
                                  'เลือกรูป',
                                  style: GoogleFonts.kanit(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      FontAwesomeIcons.cameraRetro,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: fullnameCtrl,
                  style: GoogleFonts.kanit(),
                  decoration: InputDecoration(
                    labelText: 'ชื่อ-สกุล',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'ป้อนชื่อนามสกุล',
                    hintStyle: GoogleFonts.kanit(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.kanit(),
                  decoration: InputDecoration(
                    labelText: 'อีเมล์',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'ป้อนอีเมล์',
                    hintStyle: GoogleFonts.kanit(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.kanit(),
                  decoration: InputDecoration(
                    labelText: 'เบอร์โทร',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'ป้อนเบอร์โทร',
                    hintStyle: GoogleFonts.kanit(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: usernameCtrl,
                  style: GoogleFonts.kanit(),
                  decoration: InputDecoration(
                    labelText: 'ชื่อผู้ใช้',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'ป้อนชื่อผู้ใช้',
                    hintStyle: GoogleFonts.kanit(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  obscureText: passwordShowFlag,
                  controller: passwordtrl,
                  style: GoogleFonts.kanit(),
                  decoration: InputDecoration(
                    labelText: 'รหัสผ่าน',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'ป้อนรหัสผ่าน',
                    hintStyle: GoogleFonts.kanit(
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (passwordShowFlag == true) {
                            passwordShowFlag = false;
                          } else {
                            passwordShowFlag = true;
                          }
                        });
                      },
                      icon: Icon(
                        passwordShowFlag == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  //Validate หน้าจอ ณ ที่นี้คือตรวจสอบว่าผ้อนครบไหม / เลือกรูปรึยัง
                  //หากยังให้แสดง Dialog เตือน
                  //ป้อนครบเรียบร้อยแล้วให้บันทึกลง  Database: SQLite แล้วกลับไปหน้า Login
                  if (fullnameCtrl.text.trim().length == 0) {
                    showWarningDialog(context, 'ป้อนชื่อ-สกุลด้วย...');
                  } else if (emailCtrl.text.trim().length == 0) {
                    showWarningDialog(context, 'ป้อนอีเมลด้วย...');
                  } else if (phoneCtrl.text.trim().length == 0) {
                    showWarningDialog(context, 'ป้อนเบอร์โทรศัพท์ด้วย...');
                  } else if (usernameCtrl.text.trim().length == 0) {
                    showWarningDialog(context, 'ป้อนชื่อผู้ใช้ด้วย...');
                  } else if (passwordtrl.text.trim().length == 0) {
                    showWarningDialog(context, 'ป้อนรหัสผ่านด้วย...');
                  } else if (pictureDir!.length == 0) {
                    showWarningDialog(context, 'เลือกหรือถ่ายรูปด้วย...');
                  } else {
                    //ผ่าน if ทั้งหมดมาพร้อมที่จะนำข้อมูลเก็บลง Database: Sqlite
                    saveUserToDB(context);
                  }
                },
                child: Text(
                  'ลงทะเบียน',
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
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
