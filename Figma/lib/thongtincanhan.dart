import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:figma/database_helper.dart';
import 'UserModel.dart';
import 'UserGlobal.dart';
import 'package:figma/dangnhap.dart';
import 'package:figma/canhan.dart';

typedef FunctionCallback = void Function(String name);

class thongtincanhan extends StatefulWidget {
  thongtincanhan({super.key, required this.name});

  final FunctionCallback name;

  @override
  State<StatefulWidget> createState() {
    return _thongtincanhan();
  }
}

class _thongtincanhan extends State<thongtincanhan> {
  final _formKey = GlobalKey<FormState>();
  User? thongTinUser;
  DbHelper? dbHelper;
  UserModel? user;
  String sdt = '0777805979';
  String cccd = '331932406';
  final _nameController = TextEditingController();
  final _cmndController = TextEditingController();
  final _sdtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    thongTinUser = FirebaseAuth.instance.currentUser;
    String tempUserID = '';
    if (user != null) {
      // Người dùng đã đăng nhập
      tempUserID = dataGlobal.ID!;

      if (user != null) {
        // Người dùng đã đăng nhập bằng Google

          _nameController.text = user?.user_name ?? '';
          _sdtController.text = user?.phone_number ?? '';
          _cmndController.text = user?.id_number ?? '';

      }
    } else {
      // Người dùng đã đăng nhập bằng email và mật khẩu


      
        _nameController.text = thongTinUser?.displayName ?? '';
        _sdtController.text = sdt;
        _cmndController.text = cccd;

    }
  }

  void dispose() {
    _nameController.dispose();
    _cmndController.dispose();
    _sdtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                    alignment: AlignmentDirectional.topCenter,
                    height: 70,
                    width: 450,
                    padding: EdgeInsets.only(top: 17, left: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 40,
                          ),
                          onTap: () {
                            Navigator.pop(
                              context,
                              true,
                            );
                          },
                        ),
                        const Text(
                          '    Thông tin cá nhân',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Sarabun',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 38, left: 10),
                  child: Icon(
                    Icons.account_circle,
                    size: 120,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 40,
                  width: 390,
                  margin: EdgeInsets.only(top: 38, left: 10),
                  child: TextFormField(
                    controller: _nameController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 390,
                  margin: EdgeInsets.only(top: 38, left: 10),
                  child: TextFormField(
                    controller: _sdtController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 390,
                  margin: EdgeInsets.only(top: 38, left: 10, bottom: 38),
                  child: TextFormField(
                    controller: _cmndController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _update();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cập nhật thành công ')),
                        );
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
                      'Cập nhật',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    )),
              ])))
    ])));
  }

  Future<void> _update() async {
    String uname = _nameController.text;
    String uPhoneNumber = _sdtController.text;
    String uIdNumber = _cmndController.text;
    print(uname);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserModel user1 = UserModel(
          user_name: uname, phone_number: uPhoneNumber, id_number: uIdNumber);
      //await DbHelper.updateUser(user).then((value) => Navigator.of(context).pop());
      await DbHelper.updateUser(user1);
      widget.name(uname);
      print(user1.user_name);
    }
  }
}
