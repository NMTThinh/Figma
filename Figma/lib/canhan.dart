import 'package:figma/choose.dart';
import 'package:figma/thongtincanhan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:figma/trangchu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UserModel.dart';
import 'dangky.dart';
import 'database_helper.dart';

import 'UserGlobal.dart';

class canhan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _canhan();
  }
}

class _canhan extends State<canhan> {
  User? thongTinUser;
  String? name;
  DbHelper? dbHelper;
  UserModel? user;
  bool _isSigningOut = false;
// Tạo một hàm để lấy đối tượng SharedPreferences
  Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

// Tạo một hàm để lưu trạng thái đăng nhập
  Future<void> saveLoginStatus(bool status) async {
    // Lấy đối tượng SharedPreferences
    final prefs = await getPrefs();
    // Lưu giá trị bool với key "IS_LOGGED_IN"
    await prefs.setBool("IS_LOGGED_IN", status);
  }

// Tạo một hàm để lấy trạng thái đăng nhập
  Future<bool> getLoginStatus() async {
    // Lấy đối tượng SharedPreferences
    final prefs = await getPrefs();
    // Lấy giá trị bool với key "IS_LOGGED_IN" và giá trị mặc định là false
    return prefs.getBool("IS_LOGGED_IN") ?? false;
  }
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    thongTinUser = FirebaseAuth.instance.currentUser;
    String tempUserID = '';
    if (user != null) {
      // Người dùng đã đăng nhập
      tempUserID = dataGlobal.ID!;

      dbHelper = DbHelper();
      dbHelper?.getUserById(tempUserID);
      user = await dbHelper?.getUserById(tempUserID);
      if (user != null) {
        // Người dùng đã đăng nhập bằng Google
        setState(() {
          name = user?.user_name ?? '';
        });
      }
    } else {
      // Người dùng đã đăng nhập bằng email và mật khẩu
      setState(() {
        name = thongTinUser?.displayName;
      });
    }
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => dangky(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: 500,
        height: 500,
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 30, left: 18),
        child: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40,
          ),
          onTap: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => trangchu()));
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 30, left: 350),
        child: GestureDetector(
          onTap: () async {
            await Navigator.push<bool?>(
                context,
                MaterialPageRoute(
                    builder: (context) => thongtincanhan(
                          name: (data) {
                            setState(() {
                              name = data;
                            });
                          },
                        )));
          },
          child: Icon(
            Icons.create,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 60, left: 150),
        child: Icon(
          Icons.account_circle,
          size: 120,
          color: Colors.white,
        ),
      ),
      Container(
        height: 24,
        width: 300,
        margin: EdgeInsets.only(top: 180, left: 60),
        alignment: Alignment.center,
        child: Text(
          name ?? '',
          style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.w400),
        ),
      ),
      Container(
        width: 450,
        height: 464,
        margin: EdgeInsets.only(top: 210),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
      ),
      Container(
        width: 180,
        height: 55,
        margin: EdgeInsets.only(top: 230),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.assignment,
              size: 32,
              color: Colors.black,
            ),
            Text(
              'Hồ sơ của tôi',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 245, left: 350),
        child: Icon(
          Icons.chevron_right,
          color: Colors.black,
          size: 32,
        ),
      ),
      Container(
        width: 500,
        height: 2,
        margin: EdgeInsets.only(top: 290),
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
      Container(
        width: 125,
        height: 55,
        margin: EdgeInsets.only(top: 300),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.assignment_late,
              size: 32,
              color: Colors.black,
            ),
            Text(
              'Góp ý',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 315, left: 350),
        child: Icon(
          Icons.chevron_right,
          color: Colors.black,
          size: 32,
        ),
      ),
      Container(
        width: 500,
        height: 2,
        margin: EdgeInsets.only(top: 370),
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      ),
      Container(
        width: 160,
        height: 55,
        margin: EdgeInsets.only(top: 380),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.input,
              size: 32,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () async {
              setState(() {
                _isSigningOut = true;
              });
              await Authentication.signOut(context: context);
              setState(() {
                _isSigningOut = false;
              });
              // Giả sử người dùng đã đăng xuất
              // Gọi hàm saveLoginStatus để lưu trạng thái đăng xuất vào shared preferences
              await saveLoginStatus(false);
              // Chuyển về màn hình đăng nhập
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Choose()));
            }, child:const Text(
              'Đăng xuất',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w500),
            ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 385, left: 350),
        child: Icon(
          Icons.chevron_right,
          color: Colors.black,
          size: 32,
        ),
      ),
    ]));
  }
}
