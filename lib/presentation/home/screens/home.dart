
import 'package:epl/presentation/favourite/favouriteHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../videos/screens/Videos.dart';
import '../../videos/screens/Videos2.dart';
import '../../competations/screens/Competition.dart';
import 'homMatches.dart';
import 'dart:ui' as ui;

import '../../news/screens/news.dart';

class home extends StatefulWidget {
  DateTime? dateTime;
  int index;
  home({this.dateTime,required this.index});
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {



  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    static List<Widget> _widgetOptions=[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  bool isSwitched = false;

  final locale = Get.locale!.countryCode;
  DateTime? dateScheduale;
  var today = '';

  @override
  void initState() {

    _widgetOptions = <Widget>[
    Matches(dateTime: widget.dateTime!,),
    News(),
    // Reels(),
      Videos(),
    FavouriteHome(tag: 'الفرق'),
    Competition(tag: 'البطولات',),
    ];



    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        initializeDateFormatting("EN_SA", null).then((_) {
          var now = new DateTime.now();
          DateFormat.MMMEd('EN_SA').format(now);
          _selectedIndex = widget.index;
          today = DateFormat("dd-MM-yyyy", 'EN_SA')
              .format(now.subtract(new Duration(days: 0)));
        });
      });


    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          locale == 'US' ? ui.TextDirection.ltr : ui.TextDirection.rtl,
      child: Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 0,),
                child: _selectedIndex==0?Container(
                  width: 25,height: 25,
                  child: Image.asset('assets/Icons/Mask Group 232.png',
                    color: _selectedIndex == 0
                      ? Color.fromRGBO(95, 31, 117, 1.0)
                      : Colors.grey,),
                ):Container(
                  width: 22,height: 22,
                  child: Image.asset('assets/Icons/Mask Group 232.png',
                    color: _selectedIndex == 0
                        ? Color.fromRGBO(95, 31, 117, 1.0)
                        : Colors.grey,),
                ),
              ),
              label: "المباريات".tr,

            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 0,left: 0),
                  child: new Container(
                    height: 19,width: 19,
                    child: Image.asset('assets/Icons/Mask Group 236.png',
                      color: _selectedIndex == 1
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey,),
                  ),
                ),
                label: "الأخبار".tr
                // title: Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: new Text(
                //     "الأخبار".tr,
                //     style: TextStyle(                      fontFamily: 'Vazirmatn',
                //         fontWeight: FontWeight.w400,
                //         color: _selectedIndex == 1
                //             ? Color.fromRGBO(95, 31, 117, 1.0)
                //             : Colors.grey),
                //   ),
                // )
                ),
            /*
            BottomNavigationBarItem(
                icon:Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:_selectedIndex == 2
                            ? Color.fromRGBO(95, 31, 117, 1.0)
                            :Colors.white
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.video_collection_outlined,
                        color: _selectedIndex == 2
                            ? Colors.white
                            : Colors.grey
                        ,size: 35, ),
                    ),
                  ),
                ),
                label: "Reels".tr
                // title: Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: new Text(
                //     "Reels".tr,
                //     style: TextStyle(                      fontFamily: 'Vazirmatn',
                //         fontWeight: FontWeight.w400,
                //         color: _selectedIndex == 2
                //             ? Color.fromRGBO(95, 31, 117, 1.0)
                //             : Colors.grey),
                //   ),
                // )
            ),

             */
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 0,),
                  child: new Container(
                    height: 23,width: 23,
                    child: Image.asset('assets/Icons/Mask Group 235.png',
                      color: _selectedIndex == 2
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey,),
                  ),
                ),
                label: "الفيديو".tr
                // title: Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: new Text(
                //     "الفيديو".tr,
                //     style: TextStyle(                      fontFamily: 'Vazirmatn',
                //         fontWeight: FontWeight.w400,
                //         color: _selectedIndex == 3
                //             ? Color.fromRGBO(95, 31, 117, 1.0)
                //             : Colors.grey),
                //   ),
                // )
                ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 0,),
                  child: new Container(
                    height: 20,width: 20,
                    child: Image.asset('assets/Icons/Mask Group 239.png',
                      color: _selectedIndex == 3
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey,),
                  ),
                ),
                label: "المفضلة".tr
                // title: new Text(
                //   "البطولات".tr,
                //   style: TextStyle(                      fontFamily: 'Vazirmatn',
                //       fontWeight: FontWeight.w400,
                //       color: _selectedIndex == 4
                //           ? Color.fromRGBO(95, 31, 117, 1.0)
                //           : Colors.grey),
                // )
                ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 0,),
                  child: new Container(
                    height: 20,width: 20,
                    child: Image.asset('assets/Icons/Mask Group 237.png',
                      color: _selectedIndex == 4
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey,),
                  ),
                ),
                label: "البطولات".tr),

            /*
          BottomNavigationBarItem(
            icon: Icon(Icons.menu,
                color: _selectedIndex == 4
                    ? Color.fromRGBO(95, 31, 117, 1.0)
                    : Colors.grey),
            title: Text(
              "المزيد".tr,
              style: TextStyle(                      fontFamily: 'Vazirmatn',
                  fontWeight: FontWeight.w400,
                  color: _selectedIndex == 4
                      ? Color.fromRGBO(95, 31, 117, 1.0)
                      : Colors.grey),
            ),
          ),

           */
          ],
          currentIndex:  _selectedIndex,
          selectedItemColor: Color.fromRGBO(95, 31, 117, 1.0),
          selectedIconTheme: IconThemeData(size: 35),
          unselectedIconTheme: IconThemeData(size: 20),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
