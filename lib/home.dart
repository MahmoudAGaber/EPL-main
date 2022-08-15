
import 'package:arseli/News/latest.dart';
import 'package:arseli/Provider/LeaguesViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/Provider/NewsViewModel.dart';
import 'package:arseli/Provider/VideosViewModel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Reels.dart';
import 'Videos.dart';
import 'favourites.dart';
import 'leagues.dart';
import 'matches.dart';
import 'dart:ui' as ui;

class home extends StatefulWidget {
  DateTime dateTime;
  home({this.dateTime});
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  LeaguesViewModel leaguesViewModel;
  VideosViewModel videosViewModel;
  NewsViewModel newsViewModel;
  MatchesViewModel matchesViewModel;
  PageController _pageController = PageController();
  List<Widget> _childern=[];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  bool isSwitched = false;


  final locale = Get.locale.countryCode;
  DateTime dateScheduale;
  var today = '';

  @override
  void initState() {
    _childern = [
      Matches(dateTime: widget.dateTime,),
      latest(),
      // Reels(),
      Videos(),
      Favourites(),
      Leagues(),

      // More(),
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      setState(() {
        initializeDateFormatting("EN_SA", null).then((_) {
          var now = new DateTime.now();
          DateFormat.MMMEd('EN_SA').format(now);

          today =
              DateFormat("dd-MM-yyyy",'EN_SA').format(now.subtract(new Duration(days: 0)));
          matchesViewModel.getMatches(today);
        });
      });

      matchesViewModel = Provider.of(context,listen:false);
      newsViewModel = Provider.of(context,listen:false);
      videosViewModel = Provider.of(context,listen:false);
      leaguesViewModel = Provider.of(context,listen:false);

      newsViewModel.getNews(1, "1");
      videosViewModel.getVideos('تقارير ومؤتمرات صحفية'.tr,0,"");
      leaguesViewModel.getDataLeagues();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print('heeerrree');
    return Directionality(
      textDirection: locale == 'US' ? ui.TextDirection.ltr : ui.TextDirection.rtl,
      child:Scaffold(
        body:PageView(
          controller: _pageController,
          children: _childern,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: _onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10.0,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 10,top: 13),
                child: new Icon(MdiIcons.soccerField,
                    color: _selectedIndex == 0
                        ? Color.fromRGBO(95, 31, 117, 1.0)
                        : Colors.grey),

              ),
              label:"المباريات".tr ,
              // title: Padding(
              //
              //   padding: const EdgeInsets.only(right: 10),
              //   child: new Text(
              //     "المباريات".tr,
              //
              //     style: TextStyle(
              //         fontWeight: FontWeight.w400,
              //         color: _selectedIndex == 0
              //             ? Color.fromRGBO(95, 31, 117, 1.0)
              //             : Colors.grey),
              //   ),
              // )
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 10,top: 13),
                  child: new Icon(MdiIcons.newspaperVariant,
                      color: _selectedIndex == 1
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey),
                ),
                label: "الأخبار".tr
              // title: Padding(
              //   padding: const EdgeInsets.only(left: 10),
              //   child: new Text(
              //     "الأخبار".tr,
              //     style: TextStyle(
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
                //     style: TextStyle(
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
                  padding: const EdgeInsets.only(left: 10,top: 13),
                  child: new Icon(Icons.videocam_rounded,
                      color: _selectedIndex == 2
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey),
                ),
                label: "الفيديو".tr
              // title: Padding(
              //   padding: const EdgeInsets.only(left: 10),
              //   child: new Text(
              //     "الفيديو".tr,
              //     style: TextStyle(
              //         fontWeight: FontWeight.w400,
              //         color: _selectedIndex == 3
              //             ? Color.fromRGBO(95, 31, 117, 1.0)
              //             : Colors.grey),
              //   ),
              // )
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: new Icon(MdiIcons.star,
                      color: _selectedIndex == 3
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey),
                ),
                label: "البطولات".tr
              // title: new Text(
              //   "البطولات".tr,
              //   style: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       color: _selectedIndex == 4
              //           ? Color.fromRGBO(95, 31, 117, 1.0)
              //           : Colors.grey),
              // )
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: new Icon(MdiIcons.trophy,
                      color: _selectedIndex == 4
                          ? Color.fromRGBO(95, 31, 117, 1.0)
                          : Colors.grey),
                ),
                label: "المفضلة".tr
            ),


            /*
          BottomNavigationBarItem(
            icon: Icon(Icons.menu,
                color: _selectedIndex == 4
                    ? Color.fromRGBO(95, 31, 117, 1.0)
                    : Colors.grey),
            title: Text(
              "المزيد".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: _selectedIndex == 4
                      ? Color.fromRGBO(95, 31, 117, 1.0)
                      : Colors.grey),
            ),
          ),

           */
          ],
        ),

      ),
    );
  }
}