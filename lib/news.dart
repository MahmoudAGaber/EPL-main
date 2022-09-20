import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'News/forYou.dart';
import 'News/latest.dart';
import 'News/leagues.dart';
import 'News/transference.dart';

class news extends StatefulWidget {
  @override
  _newsState createState() => _newsState();
}

class _newsState extends State<news> with SingleTickerProviderStateMixin {
  TabController tabController;
  bool isSwitched = false;

  static const TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Colors.white);

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Row(
              children: <Widget>[Text("الأخبار".tr,style: TextStyle(color: Colors.white),)],
            ),
          ),
          bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Align(
            alignment: Alignment.centerRight,
            child:DefaultTabController(
              length: 2,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).backgroundColor,
                child: TabBar(
                  isScrollable: true,
                  controller: tabController,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  labelStyle: tapbar,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "الكل".tr,
                        style: tapbar,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "الاحدث".tr,
                        style: tapbar,
                      ),
                    ),
                 /*
                    Tab(
                      child: Text(
                        "انتقالات".tr,
                        style: tapbar,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "البطولات".tr,
                        style: tapbar,
                      ),
                    ),

                  */

                  ],
                ),
              ),
            ),
          ),
        ),),
        body: TabBarView(
          controller: tabController,
          children: [
            new Scaffold(body: ForYou()),
            new Scaffold(body: latest()),
            /*
            new ListView(
              children: <Widget>[
                transference(),
              ],
            ),
            new Scaffold(
              body: leagues(),
            ),

             */
          ],
        ),
      ),
    );
  }
}
