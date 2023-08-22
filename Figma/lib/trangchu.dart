import 'package:flutter/material.dart';
import 'package:figma/canhan.dart';

class trangchu extends StatelessWidget {
  const trangchu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              Container(
                  alignment: AlignmentDirectional.topStart,
                  height: 100,
                  width: 450,
                  padding: EdgeInsets.only(top: 17,left: 15),
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child:const Text('QUẬN 10 TRỰC TUYẾN',
                        style: TextStyle(color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w500),),

                  ),
               Container(
                  height: 20,
                  margin: EdgeInsets.only(top:50,left: 17),
                  child:const Text('Xin chào, Ông/Bà',
                    style: TextStyle(color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.w400),),
                ),
              Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(top: 5,left: 295),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => canhan()));
                          },
                           child: Icon(
                             Icons.account_circle_outlined,
                             color: Colors.white,
                             size: 24,)),
                      Icon(Icons.notification_add,color: Colors.white,size: 24,)
                    ],
                  ),
                ),
              Container(
                  width: 450,
                  height: 800,
                  margin: EdgeInsets.only(top: 80),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                ),
              Container(
                padding:const EdgeInsets.only(top: 80,left: 8),
                child:const Text('Tra cứu hồ sơ',
                  style: TextStyle(color: Colors.orange,
                      fontSize: 20,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.w600),),
              ),
              Container(
                padding:const EdgeInsets.only(top: 110,left: 17),
                child:const Text('Ông/Bà vui lòng nhập hoặc quét mã số biên nhận để tra cứu',
                  style: TextStyle(color: Colors.grey,
                      fontSize: 16  ,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.w400),),
              ),
              Container(
                width: 385,
                height: 50,
                margin: EdgeInsets.only(top: 170,left: 12),
                padding:EdgeInsets.all(2) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blue,width: 3)
                ),
                child:const Row(
                  children: [
                   Image(image: AssetImage('assets/qr.png'),width: 32,height: 32,),
                    Text('  Mã số biên nhận của Ông/Bà',
                      style: TextStyle(color: Colors.grey,
                          fontSize: 14  ,
                          fontFamily: 'Sarabun',
                          fontWeight: FontWeight.w400),),
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 270),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                    Image(image: AssetImage('assets/hinh1.png'),width: 130,height: 150,),
                    Image(image: AssetImage('assets/hinh2.png'),width: 130,height: 150,),
                    Image(image: AssetImage('assets/hinh3.png'),width: 130,height: 150,),
                  ],
                ),
              ),
              Container(
                height: 500,
                width: 420,
                margin: EdgeInsets.only(top: 460),
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const  Text('Thông tin tuyên truyền, cổ động',
                        style: TextStyle(color: Colors.orange,
                            fontSize: 20 ,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.w700),),
                      const   Row(
                        children: [
                          Image(image: AssetImage('assets/hinh4.png'),width: 130,height: 120,),
                          Text('Thông tin công tác phòng,chống\ndịch bệnh Covid-19 trên địa bàn... ',
                            style: TextStyle(color: Colors.black,
                                fontSize: 16 ,
                                fontFamily: 'Sarabun',
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey
                        ),
                      ),
                      const  Row(
                        children: [
                          Image(image: AssetImage('assets/hinh5.png'),width: 130,height: 120,),
                          Text('Thông tin công tác phòng,\ndịch bệnh Covid-19 trên địa bàn... ',
                            style: TextStyle(color: Colors.black,
                                fontSize: 16 ,
                                fontFamily: 'Sarabun',
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                        height: 2,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.grey
                        ),
                      ),
                      const  Row(
                        children: [
                          Image(image: AssetImage('assets/hinh6.png'),width: 130,height: 120,),
                          Text('Thông tin công tác phòng,chống\ndịch bệnh Covid-19 trên địa bàn... ',
                            style: TextStyle(color: Colors.black,
                                fontSize: 16 ,
                                fontFamily: 'Sarabun',
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                        ],
                      )

                        ),
                      )
            ]
        )
    );
  }
}