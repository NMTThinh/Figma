import 'package:figma/dangky.dart';
import 'package:figma/dangnhap.dart';
import 'package:figma/showthongtin.dart';
import 'package:flutter/material.dart';

class Choose extends StatefulWidget {
  Choose({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Choose();
  }
}

class _Choose extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(
    children: [
    SingleChildScrollView(
    child: Form(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: AlignmentDirectional.topStart,
        height: 70,
        width: 450,
        padding: EdgeInsets.only(top: 30,left: 25),
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: const Text(
          'NMTThinh xin chào.',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.w500),
        ),
      ),

      Container(
          margin: EdgeInsets.only(top:20,left: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
            child: Row(
              children: [
                Icon(Icons.add),
                GestureDetector(
                  child: Text(
                      ' Đăng ký tài khoản:',
                    style: TextStyle(
                      color: Colors.deepPurple,
                        fontSize: 20,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => dangky()));
                  },
                ),
              ],
            )
      ),
      Container(

          margin: EdgeInsets.only(top: 20, left: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.add),
              GestureDetector(
                child: Text(
                  ' Đăng nhập tài khoản:',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.w500
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => dangnhap()));
                },
              ),
            ],
          )
      ),
      Container(

          margin: EdgeInsets.only(top: 20,left: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.add),
              GestureDetector(
                child: Text(
                  ' Các tài khoản đã đăng kí:',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.w500
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ShowUser()));
                },
              ),
            ],
          )
      ),
      ]
    )
    )
    )
    ]
    )
    );

  }
}
