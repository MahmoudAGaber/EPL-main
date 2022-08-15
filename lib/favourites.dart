import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'More.dart';
import 'favourite/favouriteLeague.dart';
import 'favourite/favouritePlayer.dart';
import 'favourite/favouriteTeam.dart';
import 'package:get/get.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: <Widget>[
              Text(
                "المفضلة".tr,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),),
        /*
        drawer: Drawer(
          child: More(),
        ),

         */
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Container(
                    height: 60,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Icon(Icons.search,color: Colors.grey,),
                          ),
                          hintText: "ابحث عن فريق",
                          hintStyle: TextStyle(color: Colors.grey)
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('اتابعهم',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  height: 260,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (BuildContext context,index){
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 45,
                                      height: 45,
                                      child: Image.asset('assets/fc.jpg')),
                                  Text('برشلونة')
                                ],)
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('مقترحة',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context,index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Container(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          child: Image.asset('assets/fc.jpg')
                                      ),
                                      SizedBox(width: 4,),
                                      Text('برشلونة')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    width: 45,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Center(child: Text('تابع',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 12,fontWeight: FontWeight.bold),)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addDialogTeam() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.only(top: 30, right: 10, left: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 5, right: 10, left: 10),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration.collapsed(
                                hintText:
                                "البحث عن الفرق،المقابلات،اللاعبين،الاخبار،البطولات"
                                    .tr,
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child:
                                            Image.asset("assets/541.jpg"),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("ريال مدريد".tr)
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.star_border),
                                        onPressed: null)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ));
        });
  }

  addDialogPlayers() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.only(top: 20, right: 10, left: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 5, right: 10, left: 10),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.grey[500],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration.collapsed(
                                hintText:
                                "البحث عن الفرق،المقابلات،اللاعبين،الاخبار،البطولات"
                                    .tr,
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          border: Border.all(
                                              width: 1, color: Colors.grey)),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          child: Image.asset(
                                              "assets/Marcelo.jpg")),
                                    ),
                                    Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text("مارسيلو".tr),
                                            IconButton(
                                                icon: Icon(Icons.star_border),
                                                onPressed: null)
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ));
        });
  }

  addDialogLeagues() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.only(top: 20, right: 10, left: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 5, right: 10, left: 10),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.grey[500],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration.collapsed(
                                hintText:
                                "البحث عن الفرق،المقابلات،اللاعبين،الاخبار،البطولات"
                                    .tr,
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.asset("assets/12.jpg"),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "اسبانيا-الدوري الاسباني الدرجة الاولي"
                                                  .tr)
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.star_border),
                                        onPressed: null)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ));
        });
  }

  List<Widget> _listIcons() {
    List<Widget> list = new List();
    list.add(Row(
      children: <Widget>[
        Icon(Icons.edit),
        SizedBox(
          width: 15,
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            addDialogTeam();
          },
        ),
        SizedBox(
          width: 8,
        )
      ],
    ));

    list.add(Row(
      children: <Widget>[
        Icon(Icons.edit),
        SizedBox(
          width: 15,
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            addDialogPlayers();
          },
        ),
        SizedBox(
          width: 8,
        )
      ],
    ));

    list.add(Row(
      children: <Widget>[
        Icon(Icons.edit),
        SizedBox(
          width: 15,
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            addDialogLeagues();
          },
        ),
        SizedBox(
          width: 8,
        )
      ],
    ));

    return list;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Theme.of(context).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
