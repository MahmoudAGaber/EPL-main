import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class allDetaials extends StatefulWidget {
  @override
  _allDetaialsState createState() => _allDetaialsState();
}

TextStyle content = TextStyle(fontSize: 14);
TextStyle content2 = TextStyle(fontSize: 12, color: Colors.grey);
TextStyle number = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

TextStyle _textStyletitle = TextStyle(fontSize: 18);

class _allDetaialsState extends State<allDetaials> {
  int i = 1;
  String leauesVal;
  String statisticsVal;
  List _leaguesName = ['ahmed', 'gaber', 'ali', 'aya'];

  List _statisticsName = [
    'أهداف'.tr,
    "ابعاد الكرات في كل مباراة".tr,
    "اعتراض ناجح لكل مباراة".tr,
    "التسديدات في المرمي لكل مباراة".tr,
    "السيطرة في الثلث النهائي".tr,
    "بطاقات صفراء".tr,
    "تصديات لكل مباراة".tr,
    "تقييم اللعب".tr,
    "تمريرات دقيقة لكل مباراة".tr,
    "تمريرات مهمة لكل مقابلة".tr,
    "شباك نظيفة".tr,
    "صناعة".tr,
    "عدد الدقائق لكل هدف".tr,
    "فرصة كبيرة ضاعت".tr,
    "فرصة كبيرة نفذت",
    "مراوغات ناجحة لكل مباراة".tr
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ريال مدريد".tr,
            style: _textStyletitle,
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: DropdownButton(
                  hint: Padding(
                      padding: const EdgeInsets.only(bottom: 5, right: 10),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset("assets/12.jpg"),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "الدورس الاسباني-الدرجة الاولي".tr,
                                  style: content,
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  isDense: false,
                  autofocus: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 126, bottom: 20),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  value: leauesVal,
                  onChanged: (value) {
                    setState(() {
                      leauesVal = value;
                    });
                  },
                  items: _leaguesName.map((value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset("assets/12.jpg"),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "الدورس الاسباني-الدرجة الاولي".tr,
                                        style: content,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )));
                  }).toList(),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: DropdownButton(
                  hint: Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      "اهداف".tr,
                      style: content,
                    ),
                  ),
                  autofocus: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 165, bottom: 20),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  value: statisticsVal,
                  onChanged: (value) {
                    setState(() {
                      statisticsVal = value;
                    });
                  },
                  items: _statisticsName.map((value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 25,
                          ),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    value,
                                    style: TextStyle(fontSize: 13.5),
                                  )
                                ],
                              )),
                        ));
                  }).toList(),
                ),
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 15, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text("1"),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(color: Colors.grey)),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                child: Image.asset("assets/Marcelo.jpg"),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("مارسيليو".tr),
                                Text(
                                  "افضل لاعب:2".tr,
                                  style: content2,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(
                        "8.54",
                        style: number,
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
