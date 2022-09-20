import 'package:arseli/Matches/EndMatches/matchInfo_a.dart';
import 'package:arseli/Matches/matchInfo.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Oops.dart';

class matchesForLeague extends StatefulWidget {
  String url;
  matchesForLeague({this.url});
  @override
  _matchesForLeagueState createState() => _matchesForLeagueState();
}

class _matchesForLeagueState extends State<matchesForLeague> {
  EachLeagueViewModel oneLeagueViewModel;

  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oneLeagueViewModel = Provider.of(context, listen: false);
      oneLeagueViewModel.getMatches(widget.url, '/matches');
      var now = DateTime.now();
      print(now);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<EachLeagueViewModel>(
        builder: (context, provider, child) {
          return provider.loadingMatches
              ? Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.recentMatcheBox.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Container(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      provider.recentMatcheBox[index].date.tr,
                                      style: content,
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: provider.recentMatcheBox[index]
                                          .matchInBoxModel.length,
                                      itemBuilder:
                                          (BuildContext context, indexx) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => provider
                                                                .recentMatcheBox[
                                                                    index]
                                                                .matchInBoxModel[
                                                                    indexx]
                                                                .status ==
                                                            "Played"
                                                        ? matchInfo_a(
                                                            url: provider
                                                                .recentMatcheBox[
                                                                    index]
                                                                .matchInBoxModel[
                                                                    indexx]
                                                                .matchURL,
                                                          )
                                                        : provider
                                                                    .recentMatcheBox[
                                                                        index]
                                                                    .matchInBoxModel[
                                                                        indexx]
                                                                    .status ==
                                                                "Fixture"
                                                            ? matchInfo(
                                                                url: provider
                                                                    .recentMatcheBox[
                                                                        index]
                                                                    .matchInBoxModel[
                                                                        indexx]
                                                                    .matchURL,
                                                              )
                                                            : Oops()));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 9,
                                                    top: 9),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    /*
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.timer,
                                  color: Colors.grey[500],
                                  size: 20,
                                ),
                              )),

                           */
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
                                                                  .end,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                provider
                                                                    .recentMatcheBox[
                                                                        index]
                                                                    .matchInBoxModel[
                                                                        indexx]
                                                                    .homeTeamName,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Vazirmatn',
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 5,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .4,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 3),
                                                              child: Container(
                                                                width: 33,
                                                                height: 28,
                                                                child: provider
                                                                        .recentMatcheBox[
                                                                            index]
                                                                        .matchInBoxModel[
                                                                            indexx]
                                                                        .homeTeamLogo
                                                                        .endsWith(
                                                                            'svg')
                                                                    ? SvgPicture.network(
                                                                        "https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamLogo}",
                                                                        semanticsLabel:
                                                                            'Acme Logo')
                                                                    : Image.network(
                                                                        "https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamLogo}"),
                                                              ),
                                                            ),
                                                            provider
                                                                        .recentMatcheBox[
                                                                            index]
                                                                        .matchInBoxModel[
                                                                            indexx]
                                                                        .periodId !=
                                                                    null
                                                                ? Text(
                                                                    provider.recentMatcheBox[index].matchInBoxModel[indexx].status ==
                                                                            'Fixture'
                                                                        ? provider
                                                                            .recentMatcheBox[
                                                                                index]
                                                                            .matchInBoxModel[
                                                                                indexx]
                                                                            .matchTime
                                                                        : provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamScore ==
                                                                                null
                                                                            ? "-"
                                                                            : "${provider.recentMatcheBox[index].matchInBoxModel[indexx].homeTeamScore}"
                                                                                " - "
                                                                                "${provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamScore}",
                                                                    style: (provider.recentMatcheBox[index].matchInBoxModel[indexx].status ==
                                                                            "Fixture")
                                                                        ? TextStyle(
                                                                            fontFamily:
                                                                                'Vazirmatn',
                                                                            fontSize:
                                                                                15,
                                                                            color: Colors
                                                                                .black)
                                                                        : TextStyle(
                                                                            fontFamily:
                                                                                'Vazirmatn',
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.black54),
                                                                  )
                                                                : Text('__'),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 3),
                                                              child: Container(
                                                                  width: 33,
                                                                  height: 28,
                                                                  child: provider
                                                                          .recentMatcheBox[
                                                                              index]
                                                                          .matchInBoxModel[
                                                                              indexx]
                                                                          .awayTeamLogo
                                                                          .endsWith(
                                                                              'svg')
                                                                      ? SvgPicture.network(
                                                                          "https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamLogo}",
                                                                          semanticsLabel:
                                                                              'Acme Logo')
                                                                      : Image.network(
                                                                          "https://www.eplworld.com${provider.recentMatcheBox[index].matchInBoxModel[indexx].awayTeamLogo}")),
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
                                                            Expanded(
                                                              child: Text(
                                                                provider
                                                                    .recentMatcheBox[
                                                                        index]
                                                                    .matchInBoxModel[
                                                                        indexx]
                                                                    .awayTeamName,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Vazirmatn',
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                              ),
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
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
