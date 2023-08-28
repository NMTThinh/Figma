import 'package:flutter/material.dart';
import 'package:figma/database_helper.dart';
import 'package:figma/dangky.dart';
import 'package:figma/trangchu.dart';
import 'package:figma/UserModel.dart';
import 'package:figma/UserGlobal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dangnhap extends StatefulWidget {
  dangnhap({super.key});

  @override
  State<StatefulWidget> createState() {
    return _dangnhap();
  }
}

class _dangnhap extends State<dangnhap> {
  final _formKey = GlobalKey<FormState>();

  ///Controller
  final _sdtController = TextEditingController();
  final _passwordController = TextEditingController();

  var user = UserModel();
  late DbHelper databaseHelper;

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
  } // Tạo một biến để lưu trạng thái đăng nhập

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    databaseHelper = DbHelper();
    // Gọi hàm getLoginStatus để lấy trạng thái đăng nhập từ shared preferences
    getLoginStatus().then((value) {
      setState(() {
        // Cập nhật biến isLoggedIn với giá trị nhận được
        isLoggedIn = value;
      });
    });
  }

  void dispose() {
    _sdtController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (isLoggedIn) {
      // Nếu đã đăng nhập, chuyển sang màn hình chính
      return trangchu();
    }else {
      // Nếu chưa đăng nhập, hiển thị màn hình đăng nhập
      dangnhap();
    }
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.topStart,
              height: 70,
              width: 450,
              padding: EdgeInsets.only(top: 17, left: 15),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: const Text(
                'Vui lòng sử dụng số điện thoại đã đăng ký với\nứng dụng Quận 10 Trực Tuyến',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              width: 400,
              height: 50,
              padding: EdgeInsets.only(left: 8),
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: TextFormField(
                controller: _sdtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  hintText: 'Số điện thoại *',
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await databaseHelper
                      .getLoginUser(_sdtController.text)
                      .then((value) {
                    if (value != null) {
                      user = value;
                      dataGlobal.ID = user.id_number;
                      print('user: $user');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => trangchu()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đăng nhập thành công ')),
                      );
                    } else {
                      print('Nhập sai số điện thoại');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đăng nhập thất bại ')),
                      );
                    }
                  });
                }
                // Giả sử người dùng đã đăng nhập thành công
                // Gọi hàm saveLoginStatus để lưu trạng thái đăng nhập vào shared preferences
                await saveLoginStatus(true);
                // Cập nhật lại biến isLoggedIn với giá trị true
                setState(() {
                  isLoggedIn = true;
                });
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(166, 52),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  )),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30, left: 80),
                child: Row(
                  children: [
                    const Text(
                      'Ông/Bà chưa có tài khoản?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Sarabun',
                          fontWeight: FontWeight.w400),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => dangky()));
                      },
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ))
    ])));
  }
}
