import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'home.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

const TextStyle tapbar = TextStyle(
    fontFamily: 'Vazirmatn', fontSize: 13, fontWeight: FontWeight.w500);
TextStyle _textStyletitle =
    TextStyle(fontFamily: 'Vazirmatn', fontSize: 18, color: Colors.white);
TextStyle _textStyle = TextStyle(fontFamily: 'Vazirmatn', fontSize: 16);
TextStyle _textStyle1 =
    TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey, fontSize: 14);

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close,
            color: Colors.white,),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          /*
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 130,
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Icon(
                            Icons.tag_faces,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 220,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "يمكننا الحفاظ علي اعداداتك بأمان بحيث يمكنك مزامنتها عبر الاجهزة او استرجاعها عند اقتناء جهاز جديد"
                                      .tr,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "سجل الدخول".tr,
                                style: TextStyle(
                                    fontFamily: 'Vazirmatn',
                                    color: Colors.green),
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),

           */
          Divider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                /*
                GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, '/transferCenter');
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.loop,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "مركز الانتقالات".tr,
                            style: _textStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/tv');
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.tv,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "القنوات الناقلة".tr,
                            style: _textStyle,
                          ),
                          Text(
                            "الشرق الاوسط".tr,
                            style: _textStyle1,
                          )
                        ],
                      )
                    ],
                  ),
                ),


                 */
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder:(context)=> home(index: 0,)
                    ));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Image.asset('assets/matchsIcon.png',width: 20,height: 20,color: Colors.white,),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "المباريات".tr,
                              style: Theme.of(context).textTheme.headline2
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder:(context)=> home(index: 1,)
                    ));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/newsIcon.png',width: 20,height: 20,color: Colors.white,),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "الاخبار".tr,
                              style: Theme.of(context).textTheme.headline2
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder:(context)=> home(index: 2,)
                    ));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset('assets/video2Icon.png',width: 20,height: 20,color: Colors.white,),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "الفيديو".tr,
                              style: Theme.of(context).textTheme.headline2
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder:(context)=> home(index: 3,)
                    ));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child:Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "المفضله".tr,
                              style: Theme.of(context).textTheme.headline2
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder:(context)=> home(index: 4,)
                    ));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/cupIcon.png',width: 20,height: 20,color: Colors.white,),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "البطولات".tr,
                              style: Theme.of(context).textTheme.headline2
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/setting');
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "الاعدادات".tr,
                            style: Theme.of(context).textTheme.headline2
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
