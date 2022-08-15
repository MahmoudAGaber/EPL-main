import 'dart:async';
import 'dart:io';
import 'package:arseli/EachLeague/eachLeague.dart';
import 'package:arseli/Matches/EndMatches/matchInfo_a.dart';
import 'package:arseli/Oops.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:arseli/utils/Global.dart';
import 'package:arseli/utils/SocketUtils.dart';
import 'package:arseli/utils/Socket_Response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../main.dart';
import '../matchInfo.dart';

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

class _TodayMatchesState extends State<TodayMatches>
    with AutomaticKeepAliveClientMixin {
  TextStyle tapbar =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
  TextStyle headline = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle content = TextStyle(
    fontSize: 14,
  );

  MatchesViewModel matchesViewModel;
  Future<void> getMatches;

  bool _connectedToSocket;
  String _connectMessage;

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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      matchesViewModel = Provider.of(context, listen: false);

        getMatches = matchesViewModel.getMatches(widget.date);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      _connectedToSocket = false;
      _connectMessage = 'Connecting...';
      _connectTosocket();
    });
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<MatchesViewModel>(builder: (context, provider, child) {
          return provider.loadingMatches
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : provider.matchesList.isEmpty
                  ? Center(
                      child: NoMatches(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => provider.getMatches(widget.date),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4,bottom: 4),
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: provider.matchesList.length,
                            itemBuilder: (widget, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  elevation: 2,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                        colorScheme: ColorScheme.dark(
                                            primary: Colors.black,
                                            secondary: Colors.black)),
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
                                                  onPressed:(){},
                                                  icon: Icon(Icons.star,color: Theme.of(context).primaryColor,size: 18,)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 23,
                                                      height: 23,
                                                      child: provider
                                                          .matchesList[index].comImg
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
                                                    style: content,
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                      children: [
                                        ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: provider.matchesList[index]
                                              .subOfMathes.length,
                                          itemBuilder: (widget, indexx) {
                                            return GestureDetector(
                                              onLongPress: () {
                                                // addDialog();
                                              },
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => provider
                                                                        .matchesList[
                                                                            index]
                                                                        .subOfMathes[
                                                                            indexx]
                                                                        .status ==
                                                                    "Played" ||
                                                                provider
                                                                        .matchesList[
                                                                            index]
                                                                        .subOfMathes[
                                                                            indexx]
                                                                        .status ==
                                                                    "Playing"
                                                            ? ChangeNotifierProvider<
                                                                EachMatchViewModel>(
                                                                create: (_) =>
                                                                    EachMatchViewModel(),
                                                                child:
                                                                    matchInfo_a(
                                                                  url: provider
                                                                      .matchesList[
                                                                          index]
                                                                      .subOfMathes[
                                                                          indexx]
                                                                      .matchURL,
                                                                  homeId: provider
                                                                      .matchesList[
                                                                          index]
                                                                      .subOfMathes[
                                                                          indexx]
                                                                      .homeID,
                                                                  awayId: provider
                                                                      .matchesList[
                                                                          index]
                                                                      .subOfMathes[
                                                                          indexx]
                                                                      .awayID,
                                                                  comName: provider
                                                                      .matchesList[
                                                                          index]
                                                                      .comName,
                                                                ),
                                                              )
                                                            : provider
                                                                        .matchesList[
                                                                            index]
                                                                        .subOfMathes[
                                                                            indexx]
                                                                        .status ==
                                                                    "Fixture"
                                                                ? ChangeNotifierProvider<
                                                                    EachMatchViewModel>(
                                                                    create: (_) =>
                                                                        EachMatchViewModel(),
                                                                    child:
                                                                        matchInfo(
                                                                      url: provider
                                                                          .matchesList[
                                                                              index]
                                                                          .subOfMathes[
                                                                              indexx]
                                                                          .matchURL,
                                                                      homeId: provider
                                                                          .matchesList[
                                                                              index]
                                                                          .subOfMathes[
                                                                              indexx]
                                                                          .homeID,
                                                                      awayId: provider
                                                                          .matchesList[
                                                                              index]
                                                                          .subOfMathes[
                                                                              indexx]
                                                                          .awayID,
                                                                      comName: provider
                                                                          .matchesList[
                                                                              index]
                                                                          .comName,
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
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 5,
                                                            bottom: 9,
                                                            top: 9),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Flexible(
                                                          flex: 5,
                                                          child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .4,
                                                              height: 40,
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Text(
                                                                          provider
                                                                              .matchesList[index]
                                                                              .subOfMathes[indexx]
                                                                              .homeName,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  13,
                                                                              fontWeight:
                                                                                  FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      right: 10,
                                                                      top: 7,
                                                                      child: provider.matchesList[index].subOfMathes[indexx].status ==
                                                                              "Playing"
                                                                          ? CircleAvatar(
                                                                              minRadius:
                                                                                  13,
                                                                              backgroundColor:
                                                                                  Colors.green,
                                                                              child:
                                                                                  Padding(
                                                                                padding: const EdgeInsets.all(4.0),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(2.0),
                                                                                  child: Text(
                                                                                    provider.matchesList[index].subOfMathes[indexx].matchTime.toString(),
                                                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : provider.matchesList[index].subOfMathes[indexx].status ==
                                                                                  "Played"
                                                                              ? Container(
                                                                                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(100))),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                    child: Icon(
                                                                                      Icons.timer,
                                                                                      color: Colors.grey[500],
                                                                                      size: 20,
                                                                                    ),
                                                                                  ))
                                                                              : provider.matchesList[index].subOfMathes[indexx].status == "Fixture"
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
                                                          flex: 5,
                                                          child: Container(
                                                            height: 40,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .44,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              6),
                                                                  child:
                                                                      Container(
                                                                    width: 33,
                                                                    height: 28,
                                                                    child: provider
                                                                            .matchesList[
                                                                                index]
                                                                            .subOfMathes[
                                                                                indexx]
                                                                            .homeLogo
                                                                            .endsWith(
                                                                                'svg')
                                                                        ? SvgPicture.network(
                                                                            "https://www.eplworld.com${provider.matchesList[index].subOfMathes[indexx].homeLogo}",
                                                                            semanticsLabel:
                                                                                'Acme Logo')
                                                                        : Image.network(
                                                                            "https://www.eplworld.com${provider.matchesList[index].subOfMathes[indexx].homeLogo}"),
                                                                  ),
                                                                ),
                                                                provider
                                                                            .matchesList[
                                                                                index]
                                                                            .subOfMathes[
                                                                                indexx]
                                                                            .status ==
                                                                        'Fixture'
                                                                    ? Text(
                                                                        provider
                                                                            .matchesList[
                                                                                index]
                                                                            .subOfMathes[
                                                                                indexx]
                                                                            .time,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.black45),
                                                                      )
                                                                    : provider.matchesList[index].subOfMathes[indexx]
                                                                                .status ==
                                                                            'Postponed'
                                                                        ? Text(
                                                                            provider
                                                                                .matchesList[index]
                                                                                .subOfMathes[indexx]
                                                                                .time,
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black45,
                                                                                decoration: TextDecoration.lineThrough),
                                                                          )
                                                                        : Text(
                                                                            "${provider.matchesList[index].subOfMathes[indexx].homeScore} - ${provider.matchesList[index].subOfMathes[indexx].awayScore} ",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black),
                                                                          ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              6),
                                                                  child:
                                                                      Container(
                                                                    width: 33,
                                                                    height: 28,
                                                                    child: Image
                                                                        .network(
                                                                            "https://www.eplworld.com${provider.matchesList[index].subOfMathes[indexx].awayLogo}"),
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
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .4,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  provider
                                                                      .matchesList[
                                                                          index]
                                                                      .subOfMathes[
                                                                          indexx]
                                                                      .awayName,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
        }));
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
                    style: TextStyle(color: Colors.green, fontSize: 13)),
                Text(
                  "اضافة ريال مدريد",
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  "اضافة اتليتكو مدريد",
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  "تشغيل الاشعارات",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text("اضافة الي تقويم",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
