import 'package:figma/UserGlobal.dart';
import 'package:figma/trangchu.dart';
import 'package:flutter/material.dart';
import 'package:figma/database_helper.dart';
import 'package:figma/dangnhap.dart';
import 'package:figma/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}

class GoogleSignInButton extends StatefulWidget {
  @override
  _dangky createState() => _dangky();
}

class dangky extends StatefulWidget {
  dangky({super.key});

  @override
  State<StatefulWidget> createState() {
    return _dangky();
  }
}

class _dangky extends State<dangky> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cmndController = TextEditingController();
  final _sdtController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  late DbHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DbHelper();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() async {
    _nameController.dispose();
    _cmndController.dispose();
    _sdtController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                        alignment: AlignmentDirectional.topCenter,
                        height: 70,
                        width: 450,
                        padding: EdgeInsets.only(top: 17, left: 15),
                        decoration: const BoxDecoration(
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => dangnhap()));
                              },
                            ),
                            const Text(
                              '        Đăng ký tài khoản',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Sarabun',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Vui lòng sử dụng với thông tin thật để đăng ký',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 18,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 50,
                      padding: EdgeInsets.only(left: 8),
                      margin: EdgeInsets.only(top: 30),
                      child: TextFormField(
                        controller: _nameController,
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
                          hintText: 'Họ và tên*',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 50,
                      padding: EdgeInsets.only(left: 8),
                      margin: EdgeInsets.only(top: 30),
                      child: TextFormField(
                        controller: _cmndController,
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
                          hintText: 'Số CMND/CCCD *',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 50,
                      padding: EdgeInsets.only(left: 8),
                      margin: EdgeInsets.only(top: 30),
                      child: TextFormField(
                        controller: _sdtController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 50,
                      padding: EdgeInsets.only(left: 8),
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      child: TextFormField(
                        controller: _passwordController,
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
                          hintText: 'Mật khẩu *',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _signup();
                          }
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đăng kí thành công ')),
                            );
                          }
                          Navigator.pop(
                              context, MaterialPageRoute(builder: (context) => dangnhap()));
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              print('User is signed in!');
                            }
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
                          'Đăng kí tài khoản',
                          style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                        )),
                    Container(
                        width: 354,
                        height: 52,
                        margin: EdgeInsets.only(top: 30),
                        child: _isSigningIn
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.red,


                          ),
                        )
                            : OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isSigningIn = true;
                            });

                            User? user = await Authentication.signInWithGoogle(context: context);
                            dataGlobal.googleUser = user;
                            print(user);
                            setState(() {
                              _isSigningIn = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => trangchu()));
                          },
                          child:const Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage("assets/Google.png"),
                                  height: 33,
                                  width: 33,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    ' Google',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                  ]),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _signup() async {
    final user = UserModel(

        user_name: _nameController.text,
        id_number: _cmndController.text,
        phone_number: _sdtController.text,
        password: _passwordController.text);
    try {
      await DbHelper.saveData(user);

      Navigator.pop(context, MaterialPageRoute(builder: (context) => dangnhap()));
    } catch (e) {
      // Handle the error, e.g., show an error message
    }
  }

}