import 'package:arseli/EachLeague/eachLeague.dart';
import 'package:arseli/Provider/EachMatchViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../matchInfo.dart';

class FourDTMatchs extends StatefulWidget {
  String date;
  FourDTMatchs({this.date});
  @override
  _FourDTMatchsState createState() => _FourDTMatchsState();
}

class _FourDTMatchsState extends State<FourDTMatchs> {
  TextStyle tapbar = TextStyle(
      fontFamily: 'Vazirmatn',
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black);
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 14,
  );

  MatchesViewModel matchesViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      matchesViewModel = Provider.of(context, listen: false);
      matchesViewModel.getMatches(widget.date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Consumer<MatchesViewModel>(
        builder: (context, provider, child) {
          return provider.loadingMatches
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : provider.matchesList.isEmpty
                  ? Center(
                      child: NoMatches(),
                    )
                  : ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: provider.matchesList.length,
                      itemBuilder: (widget, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, top: 2, bottom: 2),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
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
                                                          .matchesList[index]
                                                          .comURL,
                                                    ))));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 30,
                                          child: provider
                                                  .matchesList[index].comImg
                                                  .endsWith('svg')
                                              ? SvgPicture.network(
                                                  "https://www.eplworld.com/${provider.matchesList[index].comImg}",
                                                  semanticsLabel: 'Acme Logo')
                                              : Image.network(
                                                  "https://www.eplworld.com/${provider.matchesList[index].comImg}")),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        provider.matchesList[index].comName,
                                        style: headline,
                                      ),
                                    ],
                                  ),
                                ),
                                children: [
                                  ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: provider
                                        .matchesList[index].subOfMathes.length,
                                    itemBuilder: (widget, indexx) {
                                      return GestureDetector(
                                        onLongPress: () {
                                          addDialog();
                                        },
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangeNotifierProvider<
                                                          EachMatchViewModel>(
                                                        create: (_) =>
                                                            EachMatchViewModel(),
                                                        child: matchInfo(
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
                                                      )));
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
                                                                        .matchesList[
                                                                            index]
                                                                        .subOfMathes[
                                                                            indexx]
                                                                        .homeName,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Vazirmatn',
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            /*
                                                    Positioned(
                                                      right: 10,
                                                      top: 7,
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius: BorderRadius
                                                                  .all(
                                                                  Radius.circular(
                                                                      100))),
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .all(4.0),
                                                            child: Icon(
                                                              Icons.timer,
                                                              color: Colors
                                                                  .grey[500],
                                                              size: 20,),
                                                          )),
                                                    ),

                                                     */
                                                          ],
                                                        )),
                                                  ),
                                                  Flexible(
                                                    flex: 5,
                                                    child: Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
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
                                                                    left: 6),
                                                            child: Container(
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
                                                          Text(
                                                            provider
                                                                .matchesList[
                                                                    index]
                                                                .subOfMathes[
                                                                    indexx]
                                                                .time,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Vazirmatn',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black45),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 6),
                                                            child: Container(
                                                              width: 33,
                                                              height: 28,
                                                              child: Image.network(
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
                                                      width:
                                                          MediaQuery.of(context)
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
                                                                fontFamily:
                                                                    'Vazirmatn',
                                                                fontSize: 13,
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
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                  )
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
}
