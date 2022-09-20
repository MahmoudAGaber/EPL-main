import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class playerMatches extends StatefulWidget {
  String url;
  playerMatches({this.url});
  @override
  _playerMatchesState createState() => _playerMatchesState();
}

const TextStyle _textStyle = TextStyle(
    fontFamily: 'Vazirmatn',
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.w500);

TextStyle head = TextStyle(
    fontFamily: 'Vazirmatn', fontSize: 14, fontWeight: FontWeight.w500);
TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5);
TextStyle content2 =
    TextStyle(fontFamily: 'Vazirmatn', fontSize: 13.5, color: Colors.grey);
TextStyle content3 = TextStyle(fontFamily: 'Vazirmatn', fontSize: 12);
TextStyle content4 =
    TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, color: Colors.grey);
TextStyle number = TextStyle(
    fontFamily: 'Vazirmatn', fontSize: 18, fontWeight: FontWeight.w400);

class _playerMatchesState extends State<playerMatches> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(12),
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 15,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/matchInfo_a');
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "2020/08/07",
                                  style: _textStyle,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset("assets/541.jpg"),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "دوري ابطال اوربا".tr,
                                      style: content,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 70, right: 70, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "ريال مدريد".tr,
                                  style: content,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset("assets/541.jpg"),
                                ),
                                Text("3 - 1", style: number),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset("assets/530.jpg"),
                                ),
                                Text(
                                  "اتليتكو".tr,
                                  style: content,
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "د90".tr,
                                  style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "تقييم".tr,
                                  style: _textStyle,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 20,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Center(
                                      child: Text(
                                    "7.8",
                                    style: TextStyle(
                                        fontFamily: 'Vazirmatn',
                                        color: Colors.white),
                                  )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            );
          }),
    );
  }
}
