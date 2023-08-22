import 'package:figma/database_helper.dart';
import 'package:figma/UserModel.dart';
import 'package:flutter/material.dart';


class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);
  @override
  _ShowUser createState() => _ShowUser();
}

 class _ShowUser extends State<ShowUser> {
   DbHelper? dbHelper;
   List<UserModel>? users;

   void initState() {
     super.initState();
     dbHelper = DbHelper();
     initData();
   }

   void initData() async {
     users = await dbHelper?.getAllUser();
   }


   @override
   Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(
           title: Text('Danh sách các tài khoản đã đăng ký'),
         ),
         body: users != null
             ? ListView.builder(
           itemCount: users?.length,
           itemBuilder: (context, index) {
             final user = users![index];
             return ListTile(
               leading: CircleAvatar(
               ),
               subtitle: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(user.user_name ?? ''),
                 ],
               )
             );
           },
         )
             : const Center(
           child: CircularProgressIndicator(),
         ),
     );
   }
 }