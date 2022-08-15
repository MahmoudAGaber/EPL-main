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

  static const TextStyle tapbar =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black);

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
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
          title: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Row(
              children: <Widget>[Text("اخبار".tr)],
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            labelColor: Colors.white,
            labelPadding: EdgeInsets.only(left: 50),
            indicatorPadding: EdgeInsets.only(left: 50),
            indicatorColor: Colors.deepPurple,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "لك".tr,
                  style: tapbar,
                ),
              ),
              Tab(
                child: Text(
                  "الاحدث".tr,
                  style: tapbar,
                ),
              ),
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
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            new Scaffold(body: forYou()),
            new Scaffold(body: latest()),
            new ListView(
              children: <Widget>[
                transference(),
              ],
            ),
            new Scaffold(
              body: leagues(),
            ),
          ],
        ),
      ),
    );
  }
}
