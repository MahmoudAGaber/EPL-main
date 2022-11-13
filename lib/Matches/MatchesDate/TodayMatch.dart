import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:arseli/EachLeague/eachLeague.dart';
import 'package:arseli/Matches/EndMatches/matchInfo_a.dart';
import 'package:arseli/Oops.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:arseli/Provider/ThemeProvider.dart';
import 'package:arseli/Themes/Colors.dart';
import 'package:arseli/utils/Global.dart';
import 'package:arseli/utils/SocketUtils.dart';
import 'package:arseli/utils/Socket_Response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../main.dart';
import '../matchInfo.dart';
import 'package:intl/intl.dart';
import 'dart:ui'as ui;

class TodayMatches extends StatefulWidget {
  String date;
  bool liveMatches;

  TodayMatches({this.date, this.liveMatches});

  @override
  _TodayMatchesState createState() => _TodayMatchesState();
}

class ColorConstants {
  static const kPrimaryColor = Color(0xFF394497);
  static const kSecondaryColor = Color(0xFF444FAB);
  static const kThirdSecondaryColor = Color(0xFF5E6BD8);
  static const kGravishBlueColor = Color(0xFF9BA1D2);
}

class _TodayMatchesState extends State<TodayMatches> with AutomaticKeepAliveClientMixin {
  TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black);

  MatchesViewModel matchesViewModel;
  Future<void> getMatches;
  var today = '';

  bool _connectedToSocket;
  String _connectMessage;
  bool playNow = false;
  bool favPlay = false;
  bool timePlay = false;

  _connectTosocket() async {
    G.initSocket();
    await G.socketUtils.initSocket();
    G.socketUtils.connectToSocket();
    G.socketUtils.setOnconnectListener(onConnect);
    G.socketUtils.setOnConnectionErrorListener(onConnectionError);
    G.socketUtils.setOnconnectionTimeOutListener(onConnectionTimeout);
    G.socketUtils.setOnDisconnectListener(onDisconnect);
    G.socketUtils.setOnErrorListener(onError);
    G.socketUtils.setOnMessageReceived(onMessageReceived);
  }

  onConnect(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = true;
        _connectMessage = 'Connected';
        print(_connectMessage);
      });
    }
  }

  onMessageReceived(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'message today match ';
        print(
            _connectMessage + "--> id ==>" + SocketResponse.fromJson(data).id);

        getMatches = matchesViewModel.getMatches(widget.date);
      });
    }
  }

  onConnectionError(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Connection Error';
        print(_connectMessage + data.toString());
      });
    }
  }

  onConnectionTimeout(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Connection Timeout';
        print(_connectMessage);
      });
    }
  }

  onError(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Connection Error';
        print(_connectMessage);
      });
    }
  }

  onDisconnect(data) {
    if (mounted) {
      setState(() {
        _connectedToSocket = false;
        _connectMessage = 'Disconnected';
        print(_connectMessage);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    G.socketUtils.closeConnection();
  }
  DarkThemeProvider darkThemeProvider;
  bool isDark = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      matchesViewModel = Provider.of(context, listen: false);
      darkThemeProvider = Provider.of(context, listen: false);
      isDark = darkThemeProvider.darkTheme;

      getMatches = matchesViewModel.getMatches(widget.date);
      //print(matchesViewModel.liveMatches);
      var now = new DateTime.now();
      today =  DateFormat("dd-MM-yyyy", 'EN_SA').format(now.subtract(new Duration(days: 0)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _connectedToSocket = false;
      _connectMessage = 'Connecting...';
      _connectTosocket();
    });
    return Scaffold(
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<MatchesViewModel>(builder: (context, provider, child) {
            return provider.loadingMatches
                ? Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ))
                    : RefreshIndicator(
                        onRefresh: () => provider.getMatches(widget.date),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                               widget.date == today
                                   ? Padding(
                                      padding: const EdgeInsets.only(left: 13, right: 13, top: 15, bottom: 8),
                                       child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          timePlay = favPlay;
                                          if(playNow==false){
                                            playNow = true;
                                          }
                                          else{
                                            playNow = false;
                                          }
                                          if(playNow){
                                            provider.getLiveMatches(widget.date);
                                          }
                                          else
                                          provider.getMatches(widget.date);


                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Container(
                                            width: 108,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(child: Text('تلعب الان',
                                              style: playNow
                                                  ?Theme.of(context).textTheme.headline1.copyWith(color: Color(0xFF862aa6))
                                                  :Theme.of(context).textTheme.headline1,)),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Container(
                                          width: 108,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(child: Text('مباريتي',style: Theme.of(context).textTheme.headline1,)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          playNow = false;
                                          if(timePlay==false){
                                            timePlay = true;
                                          }
                                          else{
                                            timePlay = false;
                                          }
                                          if(timePlay){
                                            provider.getMatchesByTime(widget.date);
                                          }
                                          else
                                            provider.getMatches(widget.date);


                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Container(
                                            width: 108,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(child: Text('بالوقت',
                                              style: timePlay
                                                  ?Theme.of(context).textTheme.headline1.copyWith(color: Color(0xFF862aa6))
                                                  :Theme.of(context).textTheme.headline1,)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                     )
                                   :Container(),
                                provider.matchesList.isNotEmpty
                                    ?Column(
                                     children: [
                                       timePlay
                                           ?Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 4,top: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 4,),
                                                  Icon(Icons.timer,size: 17,),
                                                  SizedBox(width: 12,),
                                                  Text('تم التصنيف بالوقت',style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14),)
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            ListView.builder(
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: provider.subOfMatches.length,
                                              itemBuilder: (widget, indexx) {
                                                return GestureDetector(
                                                  onLongPress: () {
                                                    // addDialog();
                                                  },
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => provider.subOfMatches[
                                                            indexx]
                                                                .status == "Played" || provider.subOfMatches[indexx].status == "Playing"
                                                                ? ChangeNotifierProvider<
                                                                EachMatchViewModel>(
                                                              create: (_) =>
                                                                  EachMatchViewModel(),
                                                              child:
                                                              matchInfo_a(
                                                                url: provider.subOfMatches[indexx].matchURL,
                                                                homeId: provider.subOfMatches[indexx].homeID,
                                                                awayId: provider.subOfMatches[indexx].awayID,comName: provider.matchesList[indexx].comName,
                                                              ),
                                                            )
                                                                : provider.subOfMatches[indexx].status == "Fixture"
                                                                ? ChangeNotifierProvider<
                                                                EachMatchViewModel>(
                                                              create: (_) =>
                                                                  EachMatchViewModel(),
                                                              child:
                                                              matchInfo(
                                                                url: provider.subOfMatches[indexx].matchURL,
                                                                homeId: provider.subOfMatches[indexx].homeID,
                                                                awayId: provider.subOfMatches[indexx].awayID,
                                                                comName: provider.matchesList[indexx].comName,
                                                                matchId:provider.subOfMatches[indexx].matchID
                                                              ),
                                                            )
                                                                : Oops()));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 5, right: 8, top: 9),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Flexible(
                                                              flex: 5,
                                                              child: Container(
                                                                  width: MediaQuery.of(context).size.width * .4,
                                                                  height: 40,
                                                                  child: Stack(
                                                                    children: [
                                                                      Center(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Text(
                                                                                provider.subOfMatches[indexx]
                                                                                    .homeName,
                                                                                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                                overflow: TextOverflow.clip,

                                                                                textDirection: ui.TextDirection.ltr,
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                          right: 10,
                                                                          top: 7,
                                                                          child:provider.subOfMatches[indexx].status == "Playing" ? CircleAvatar(
                                                                            minRadius: 13,
                                                                            backgroundColor: Colors.green,
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(2.0),
                                                                                child: Text(
                                                                                  provider.subOfMatches[indexx].matchTime.toString(),
                                                                                  style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                              : provider.subOfMatches[indexx].status == "Played"
                                                                              ? Container()
                                                                              : provider.subOfMatches[indexx].status == "Fixture"
                                                                              ? Container()
                                                                              : Container(
                                                                              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(100))),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(4.0),
                                                                                child: Icon(
                                                                                  Icons.date_range,
                                                                                  color: Colors.grey[500],
                                                                                  size: 20,
                                                                                ),
                                                                              ))),
                                                                    ],
                                                                  )),
                                                            ),
                                                            Flexible(
                                                              flex: 6,
                                                              child: Container(
                                                                height: 40,
                                                                width: MediaQuery.of(context).size.width * .5,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left: 13),
                                                                      child:
                                                                      Container(
                                                                        width: 35,
                                                                        height: 30,
                                                                        child:provider.subOfMatches[
                                                                        indexx]
                                                                            .homeLogo
                                                                            .endsWith(
                                                                            'svg')
                                                                            ? SvgPicture.network(
                                                                            "https://www.eplworld.com${provider.subOfMatches[indexx].homeLogo}",
                                                                            semanticsLabel:
                                                                            'Acme Logo')
                                                                            : Image.network(
                                                                            "https://www.eplworld.com${provider.subOfMatches[indexx].homeLogo}"),
                                                                      ),
                                                                    ),
                                                                    provider.subOfMatches[indexx].status == 'Fixture'
                                                                        ? Text(
                                                                      provider.subOfMatches[indexx].time,
                                                                      style: Theme.of(context).textTheme.bodyText1,
                                                                    )
                                                                        : provider.subOfMatches[indexx].status == 'Postponed'
                                                                        ? Text(
                                                                        provider.subOfMatches[indexx].time,
                                                                        style: Theme.of(context).textTheme.bodyText1
                                                                    )
                                                                        : Padding(
                                                                      padding: const EdgeInsets.only(top: 8),
                                                                      child: Text(
                                                                        "${provider.subOfMatches[indexx].homeScore} - ${provider.subOfMatches[indexx].awayScore} ",
                                                                        style: Theme.of(context).textTheme.bodyText1,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right: 13),
                                                                      child:
                                                                      Container(
                                                                        width: 35,
                                                                        height: 30,
                                                                        child: Image
                                                                            .network(
                                                                            "https://www.eplworld.com${provider.subOfMatches[indexx].awayLogo}"),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 5,
                                                              child: Container(
                                                                height: 40,
                                                                width: MediaQuery.of(context).size.width *.39,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(provider.subOfMatches[indexx].awayName,
                                                                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                        overflow: TextOverflow.clip,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),

                                                      ),
                                                      provider.subOfMatches[indexx].status == 'Played' ? Container(
                                                        width: 48,
                                                        height: 18,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: Color(0xFF862aa6),
                                                        ),
                                                        child: Center(child: FittedBox(child: Text('انتهت',style: TextStyle(color: Colors.white,fontSize: 12.5),))),
                                                      )
                                                          :Container(),
                                                      Divider()
                                                    ],
                                                  ),
                                                );
                                              },
                                              padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                           :ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: provider.matchesList.length,
                                        itemBuilder: (widget, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, top: 4, bottom: 4),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(6)),
                                              elevation: 2,
                                              child: Theme(
                                                data: Theme.of(context).copyWith(
                                                    dividerColor: Colors.transparent,
                                                    colorScheme: Theme.of(context).colorScheme),
                                                child: ExpansionTile(
                                                  initiallyExpanded: true,
                                                  title: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChangeNotifierProvider<
                                                                      EachLeagueViewModel>(
                                                                      create: (_) =>
                                                                          EachLeagueViewModel(),
                                                                      child: EachLeague(
                                                                        url: provider
                                                                            .matchesList[
                                                                        index]
                                                                            .comURL,
                                                                      ))));
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: -15,
                                                          bottom: -11,
                                                          child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                Icons.star,
                                                                color: Color(0xFF862aa6),
                                                                size: 18,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              right: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                  width: 23,
                                                                  height: 23,
                                                                  child: provider
                                                                      .matchesList[
                                                                  index]
                                                                      .comImg
                                                                      .endsWith('svg')
                                                                      ? SvgPicture.network(
                                                                      "https://www.eplworld.com/${provider.matchesList[index].comImg}",
                                                                      semanticsLabel:
                                                                      'Acme Logo')
                                                                      : Image.network(
                                                                      "https://www.eplworld.com/${provider.matchesList[index].comImg}")),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                provider.matchesList[index].comName,
                                                                style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 14),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  children: [
                                                    Divider(),
                                                    ListView.builder(
                                                      physics: ClampingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.vertical,
                                                      itemCount: playNow
                                                          ?provider.matchesList[index].subOfMathes.where((element) => element.status == "Playing").toList().length
                                                          :provider.matchesList[index].subOfMathes.length,
                                                      itemBuilder: (widget, indexx) {
                                                        final dataList = playNow
                                                            ?provider.matchesList[index].subOfMathes.where((element) => element.status == "Playing").toList()
                                                            :provider.matchesList[index].subOfMathes;
                                                        return GestureDetector(
                                                          onLongPress: () {
                                                            // addDialog();
                                                          },
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => dataList[indexx].status == "Played" || dataList[indexx].status == "Playing"
                                                                        ? ChangeNotifierProvider<
                                                                        EachMatchViewModel>(
                                                                      create: (_) =>
                                                                          EachMatchViewModel(),
                                                                      child:
                                                                      matchInfo_a(
                                                                        url:dataList[indexx].matchURL,
                                                                        homeId: dataList[indexx].homeID,
                                                                        awayId: dataList[indexx].awayID,comName: provider.matchesList[index].comName,
                                                                      ),
                                                                    )
                                                                        : dataList[indexx].status == "Fixture"
                                                                        ? ChangeNotifierProvider<
                                                                        EachMatchViewModel>(
                                                                      create: (_) =>
                                                                          EachMatchViewModel(),
                                                                      child:
                                                                      matchInfo(
                                                                        url:dataList[indexx].matchURL,
                                                                        homeId: dataList[indexx].homeID,
                                                                        awayId: dataList[indexx].awayID,
                                                                        comName: provider.matchesList[index].comName,
                                                                        matchId: dataList[indexx].matchID,
                                                                      ),
                                                                    )
                                                                        : Oops()));
                                                          },
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(left: 5, right: 8, top: 9),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Flexible(
                                                                      flex: 5,
                                                                      child: Container(
                                                                          width: MediaQuery.of(context).size.width * .4,
                                                                          height: 40,
                                                                          child: Stack(
                                                                            children: [
                                                                              Center(
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                        dataList[indexx]
                                                                                            .homeName,
                                                                                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                                        overflow: TextOverflow.clip,

                                                                                        textDirection: ui.TextDirection.ltr,
                                                                                      ),
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                  right: 10,
                                                                                  top: 7,
                                                                                  child: dataList[indexx].status == "Playing"
                                                                                      ? CircleAvatar(
                                                                                    minRadius: 13,
                                                                                    backgroundColor: Colors.green,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(2.0),
                                                                                        child: Text(
                                                                                          dataList[indexx].matchTime.toString(),
                                                                                          style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                      : dataList[indexx].status == "Played"
                                                                                      ? Container()
                                                                                      : dataList[indexx].status == "Fixture"
                                                                                      ? Container()
                                                                                      : Container(
                                                                                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(100))),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                        child: Icon(
                                                                                          Icons.date_range,
                                                                                          color: Colors.grey[500],
                                                                                          size: 20,
                                                                                        ),
                                                                                      ))),
                                                                            ],
                                                                          )),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 6,
                                                                      child: Container(
                                                                        height: 40,
                                                                        width: MediaQuery.of(context).size.width * .5,
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  left: 13),
                                                                              child:
                                                                              Container(
                                                                                width: 35,
                                                                                height: 30,
                                                                                child: dataList[indexx].homeLogo
                                                                                    .endsWith(
                                                                                    'svg')
                                                                                    ? SvgPicture.network(
                                                                                    "https://www.eplworld.com${dataList[indexx].homeLogo}",
                                                                                    semanticsLabel:
                                                                                    'Acme Logo')
                                                                                    : Image.network(
                                                                                    "https://www.eplworld.com${dataList[indexx].homeLogo}"),
                                                                              ),
                                                                            ),
                                                                            dataList[indexx].status == 'Fixture'
                                                                                ? Text(
                                                                              dataList[indexx].time,
                                                                              style: Theme.of(context).textTheme.bodyText1,
                                                                            )
                                                                                : dataList[indexx].status == 'Postponed'
                                                                                ? Text(
                                                                                dataList[indexx].time,
                                                                                style: Theme.of(context).textTheme.bodyText1
                                                                            )
                                                                                : Padding(
                                                                              padding: const EdgeInsets.only(top: 8),
                                                                              child: Text(
                                                                                "${dataList[indexx].homeScore} - ${dataList[indexx].awayScore} ",
                                                                                style: Theme.of(context).textTheme.bodyText1,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets
                                                                                  .only(
                                                                                  right: 13),
                                                                              child:
                                                                              Container(
                                                                                width: 35,
                                                                                height: 30,
                                                                                child: Image
                                                                                    .network(
                                                                                    "https://www.eplworld.com${dataList[indexx].awayLogo}"),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 5,
                                                                      child: Container(
                                                                        height: 40,
                                                                        width: MediaQuery.of(context).size.width *.39,
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(dataList[indexx].awayName,
                                                                                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),
                                                                                overflow: TextOverflow.clip,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),

                                                              ),
                                                              dataList[indexx].status == 'Played'
                                                                  ? Container(
                                                                width: 48,
                                                                height: 18,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(8),
                                                                  color: Color(0xFF862aa6),
                                                                ),
                                                                child: Center(child: FittedBox(child: Text('انتهت',style: TextStyle(color: Colors.white,fontSize: 12.5),))),
                                                              )
                                                                  :Container(),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      padding:
                                                      EdgeInsets.symmetric(vertical: 5),
                                                    ),
                                                    InkWell(
                                                        onTap: (){
                                                          Navigator.of(context,rootNavigator: true).push(
                                                              MaterialPageRoute(builder: (context) =>
                                                                  ChangeNotifierProvider<
                                                                      EachLeagueViewModel>(
                                                                      create: (_) => EachLeagueViewModel(),
                                                                      child: EachLeague(
                                                                        url: provider.matchesList[index].comURL,
                                                                      ))));
                                                        },
                                                        child: Text('الترتيب',style: TextStyle(color: Color(0xFF862aa6),fontWeight: FontWeight.bold),)),
                                                    SizedBox(height: 5,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                     ],
                                )
                                    :Padding(
                                      padding: const EdgeInsets.only(top: 100),
                                      child: NoMatchesPN(context),
                                    )

                              ],
                            ),
                          ),
                        ),
                      );
          })),
    );
  }

  addDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding:
                EdgeInsets.only(bottom: 290, top: 290, left: 90, right: 90),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("الفرق المفضلة",
                    style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        color: Colors.green,
                        fontSize: 13)),
                Text(
                  "اضافة ريال مدريد",
                  style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
                ),
                Text(
                  "اضافة اتليتكو مدريد",
                  style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
                ),
                Text(
                  "تشغيل الاشعارات",
                  style: TextStyle(
                      fontFamily: 'Vazirmatn',
                      color: Colors.grey,
                      fontSize: 13),
                ),
                Text("اضافة الي تقويم",
                    style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        color: Colors.grey,
                        fontSize: 13)),
              ],
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
