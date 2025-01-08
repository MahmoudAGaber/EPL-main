
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../league/screens/homeLeague.dart';
import 'matches/MatchesDate/TodayMatch.dart';
import 'widgets/More.dart';
import 'package:get/get.dart';
import 'widgets/clanderbar.dart';
import '../../playrers/screens/players.dart';
import '../../team/screens/teamHome.dart';

class Matches extends StatefulWidget {
  DateTime dateTime;
  Matches({required this.dateTime});
  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with SingleTickerProviderStateMixin {

  TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white);

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Creat

  bool isSwitched = false;
  bool liveMatches = false;
  bool selected = false;

  TabController? tabController;
  ScrollController? scrollViewColtroller;

  DateTime? dateScheduale;
  var today = '';
  var yesterday = '';
  var oneDayAgo = '';
  var twoDaysAgo = '';
  var tomorrow = '';
  var oneDayThen = '';
  var twoDaysThen = '';
  var threeDayThen = '';
  var fourDayThen = '';
  var fiveDayThen = '';

  var todayD = '';
  var yesterdayD = '';
  var oneDayAgoD = '';
  var twoDaysAgoD = '';
  var tomorrowD = '';
  var oneDayThenD = '';
  var twoDaysThenD = '';
  var threeDayThenD = '';
  var fourDayThenD = '';
  var fiveDayThenD = '';

  List<String> tabView = [];
  List<String> tabName = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{

      initDate();
      tabController = new TabController(length: 10, vsync: this);

      tabController!.animateTo(3, duration: Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
    });
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          centerTitle: false,
          actions:[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 10),
                child: Text(
                'EPL WORLD',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20,color: Colors.white)
          ),
              ),
            ),],
          leadingWidth: 150,
          leading: SizedBox(
            width: 200,
            height: 200,
            child: Consumer(
              builder: (context, provider, child) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        height: 25,width: 25,
                        child: Image.asset('assets/menueIcon.png'),
                      ),
                    ),

                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        searchIcon();
                      },
                      child: Container(
                        height: 25,width: 25,
                        child: Image.asset('assets/searchIcon.png'),
                      ),
                    ),
                    SizedBox(width: 25,),
                    GestureDetector(
                      onTap: (){
                       showDialog(context: context, builder: (context) => Dialog(
                          insetPadding: EdgeInsets.only(bottom: 180,top: 70),
                         child: clanderbar(),
                       ));
                      },
                      child: Container(
                        height: 25,width: 25,
                        child: Image.asset('assets/calenderIcon.png'),
                      ),
                    )

                  ],
                );
              },
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: tabController == null
              ? PreferredSize(
                  preferredSize: Size.fromHeight(50),
              child: Container())
              : PreferredSize(
            preferredSize: const Size.fromHeight(70),
                child: DefaultTabController(
            length:10 ,
                  child: Container(
                    height: 60,
                    color: Theme.of(context).primaryColor,
                    child: TabBar(
                        isScrollable: true,
                        controller: tabController,
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        labelStyle: tapbar,
                        tabs: List.generate(10, (index) {
                          return Tab(
                              child: Text(
                            tabName[index].tr,
                            style: tapbar,
                          ));
                        }),onTap: (value){

                    },),
                  ),
                ),
              ),
        ),
        backgroundColor: Colors.grey[200],
        drawer: Drawer(
          child: More(),
        ),
        body: tabController == null
            ? Container()
            : TabBarView(
                controller: tabController,
                children: List.generate(10, (index) {
                  return TodayMatches(
                    date: tabView[index],
                  );
                })));
  }

  initDate() {
    setState(() {
      initializeDateFormatting("AR_SA", null).then((_) {
        DateTime now = new DateTime.now();
        var timeNow = DateFormat.MMMEd('AR_SA').format(DateTime.now());
        // DateFormat.MMMEd('AR_SA').format(widget.dateTime??now);
        widget.dateTime == null
            ? now = new DateTime.now()
            : now = widget.dateTime;

        today = DateFormat.MMMEd('AR_SA').format(now.subtract(new Duration(days: 0)));
        yesterday = DateFormat.MMMEd('AR_SA').format(now.subtract(new Duration(days: 1)));
        oneDayAgo = DateFormat('E d', 'AR_SA').format(now.subtract(new Duration(days: 2)));
        twoDaysAgo = DateFormat('E d', 'AR_SA').format(now.subtract(new Duration(days: 3)));
        tomorrow = DateFormat.MMMEd('AR_SA').format(now.add(new Duration(days: 1)));
        oneDayThen = DateFormat('E d', 'AR_SA').format(now.add(new Duration(days: 2)));
        twoDaysThen = DateFormat('E d', 'AR_SA').format(now.add(new Duration(days: 3)));
        threeDayThen = DateFormat('E d', 'AR_SA').format(now.add(new Duration(days: 4)));
        fourDayThen = DateFormat('E d', 'AR_SA').format(now.add(new Duration(days: 5)));
        fiveDayThen = DateFormat('E d', 'AR_SA').format(now.add(new Duration(days: 6)));

        tabName = [
          twoDaysAgo,
          oneDayAgo,
          timeNow.toString() == DateFormat.MMMEd('AR_SA').format(now).toString()
              ? "امس"
              : yesterday,
          timeNow.toString() == DateFormat.MMMEd('AR_SA').format(now).toString()
              ? "اليوم"
              : today,
          timeNow.toString() == DateFormat.MMMEd('AR_SA').format(now).toString()
              ? "غدا"
              : tomorrow,
          oneDayThen,
          twoDaysThen,
          threeDayThen,
          fourDayThen,
          fiveDayThen
        ];
      });
    });

    setState(() {
      initializeDateFormatting("EN_SA", null).then((_) {
        var now = new DateTime.now();
        widget.dateTime == null
            ? now = new DateTime.now()
            : now = widget.dateTime;

        todayD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.subtract(new Duration(days: 0)));
        yesterdayD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.subtract(new Duration(days: 1)));
        oneDayAgoD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.subtract(new Duration(days: 2)));
        twoDaysAgoD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.subtract(new Duration(days: 3)));
        tomorrowD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.add(new Duration(days: 1)));
        oneDayThenD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.add(new Duration(days: 2)));
        twoDaysThenD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.add(new Duration(days: 3)));
        threeDayThenD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.add(new Duration(days: 4)));
        fourDayThenD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.add(new Duration(days: 5)));
        fiveDayThenD = DateFormat("yyyy-MM-dd", 'EN_SA').format(now.add(new Duration(days: 6)));

        tabView = [
          twoDaysAgoD,
          oneDayAgoD,
          yesterdayD,
          todayD,
          tomorrowD,
          oneDayThenD,
          twoDaysThenD,
          threeDayThenD,
          fourDayThenD,
          fiveDayThenD
        ];
      });
    });
  }

  searchIcon() {
    TextEditingController search = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                insetPadding:
                EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Consumer(
                  builder: (context, provider, child) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, right: 10, left: 10),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                    Icons.arrow_forward,
                                    color: Theme.of(context).colorScheme.background
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
                                  onChanged: (value) {

                                  },
                                  controller: search,
                                  textCapitalization:
                                  TextCapitalization.sentences,
                                  decoration: InputDecoration.collapsed(
                                      hintText:
                                      "إبحث"
                                          .tr,
                                      hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 17)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 6,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10,top: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedCategory(provider, index, search, "hi");
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                    height: 30,
                                                    width: 30,
                                                      child: Image.network("https://www.eplworld.com"),
                                                    ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.65,
                                                  child: Text('text',
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
        }).then((value) {
    });
  }

  selectedCategory( provider, index, search, searchItems) {
    var data = provider.searchItemsHome[index];
    if (data.category == 'البطولات') {
      Navigator.push(context, MaterialPageRoute(
              builder: (context) => search.text.isNotEmpty
                  ? LeagueHome(leagueName: searchItems[index].url,)
                  : LeagueHome(leagueName: data.url,)
          ));
    }
    if (data.category == 'الفرق') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => search.text.isNotEmpty
                  ? HomeTeam()
                  : HomeTeam()));
    }
    if (data.category == 'اللاعبين') {
      Navigator.push(context, MaterialPageRoute(
              builder: (context) => search.text.isNotEmpty
                  ? Players()
                  : Players()
      ));
    }
    if (data.category == 'الأخبار') {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => webView(
      //           url:
      //           "https://www.eplworld.com${data.url}",
      //         )));
    }
  }
}


