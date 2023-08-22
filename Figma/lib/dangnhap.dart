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
  late SharedPreferences prefs;


  @override
  void initState() {
    super.initState();
    initPrefs();
    databaseHelper = DbHelper();
  }
  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
 Future<void> Check() async {
   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // lấy giá trị từ shared preferences với khóa là 'isLoggedIn', nếu không có thì trả về false
   if (isLoggedIn) {
     GestureDetector(
         onTap: () {
           Navigator.push(
               context, MaterialPageRoute(builder: (context) => trangchu()));
         }
     );
   } else {
     GestureDetector(
       onTap: () {
         Navigator.push(
             context, MaterialPageRoute(builder: (context) => dangnhap()));
       },
     );
   }
 }





  void dispose() {
    _sdtController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
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
