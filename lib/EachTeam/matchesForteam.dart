import 'package:arseli/Matches/EndMatches/matchInfo_a.dart';
import 'package:arseli/Matches/matchInfo.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/MatchesViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

import '../Oops.dart';

// ignore: must_be_immutable
class MatchesForTeam extends StatefulWidget {
  String url;
  MatchesForTeam({this.url});
  @override
  _MatchesForTeamState createState() => _MatchesForTeamState();
}

class _MatchesForTeamState extends State<MatchesForTeam> {
  ScrollController con;
  double offest = 0.0;
  List dropList;
  String selectedItem;

  TextStyle head = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle content = TextStyle(fontSize: 13.5);
  TextStyle content2 = TextStyle(fontSize: 13.5, color: Colors.grey);
  TextStyle content3 = TextStyle(fontSize: 12);
  TextStyle content4 = TextStyle(fontSize: 12, color: Colors.grey[500]);
  TextStyle number = TextStyle(
    fontSize: 20,
  );

  EachTeamViewModel eachTeamViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      eachTeamViewModel = Provider.of(context, listen: false);
      eachTeamViewModel.getAllMatches(widget.url,'matches');
      dropList =eachTeamViewModel.dropsTableRows;
      selectedItem =dropList[0];
    });
    super.initState();
    con = ScrollController();

    con.addListener(() {
      if (con.offset == 100) {
        setState(() {
          con.animateTo(con.offset, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        });
      }
    });
  }

    @override
  void dispose() {
    con.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<EachTeamViewModel>(
        builder: (context,provider,child){
          return provider.loadingOneLeague
              ?Padding(padding: EdgeInsets.only(top: 35),
              child:Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor),))
              :Column(
            children: [
              DropdownButton<String>(
                value: selectedItem,
                isExpanded: true,
                menuMaxHeight: 300,
                items: provider.dropsTableRows.map((String value) {
                  return DropdownMenuItem<String>(
                    onTap: (){
                      provider.dropTableRowsList.forEach((element) {
                        if(value == element.text){
                         provider.getAllMatches(widget.url, "matches/${element.value}");
                        }
                      });
                    },
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4,left: 4),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
              ),
              ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.recentMatche.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      provider.recentMatche[index].date.tr,
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
                                      itemCount: provider.recentMatche[index].matchInBoxModel.length,
                                      itemBuilder: (BuildContext context, indexx) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context)=>provider.recentMatcheBox[index].matchInBoxModel[indexx].status == "Played"
                                                    ?matchInfo_a(url: provider.recentMatcheBox[index].matchInBoxModel[indexx].matchURL,
                                                )
                                                    :provider.recentMatcheBox[index].matchInBoxModel[indexx].status == "Fixture"
                                                    ?matchInfo(
                                                  url: provider.recentMatcheBox[index].matchInBoxModel[indexx].matchURL,
                                                )
                                                    :Oops()
                                                ));

                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9,top: 9),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                                        width: MediaQuery.of(context).size.width*.4,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              provider.recentMatche[index].matchInBoxModel[indexx].homeTeamName,
                                                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 5,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*.4,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 3),
                                                              child: Container(
                                                                width: 33,
                                                                height: 28,
                                                                child:
                                                                provider.recentMatche[index].matchInBoxModel[indexx].homeTeamLogo.endsWith('svg')
                                                                    ?SvgPicture.network("https://www.eplworld.com${ provider.recentMatche[index].matchInBoxModel[indexx].homeTeamLogo}", semanticsLabel: 'Acme Logo')
                                                                    : Image.network("https://www.eplworld.com${ provider.recentMatche[index].matchInBoxModel[indexx].homeTeamLogo}"),
                                                              ),
                                                            ),
                                                            provider.recentMatche[index].matchInBoxModel[indexx].periodId != null?
                                                            Text(
                                                              provider.recentMatche[index].matchInBoxModel[indexx].status =='Fixture'
                                                                  ?provider.recentMatche[index].matchInBoxModel[indexx].matchTime
                                                                  :provider.recentMatche[index].matchInBoxModel[indexx].status =='Postponed'
                                                                  ? '-'
                                                                  :"${provider.recentMatche[index].matchInBoxModel[indexx].homeTeamScore}"
                                                                  " - "
                                                                  "${provider.recentMatche[index].matchInBoxModel[indexx].awayTeamScore}",

                                                              style: (provider.recentMatche[index].matchInBoxModel[indexx].status=="Fixture")
                                                                  ?TextStyle(fontSize: 15,color: Colors.black)
                                                                  :TextStyle(fontSize: 15,color: Colors.black54),
                                                            ):Text('__'),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 3),
                                                              child: Container(
                                                                  width: 33,
                                                                  height: 28,
                                                                  child: provider.recentMatche[index].matchInBoxModel[indexx].awayTeamLogo.endsWith('svg')
                                                                      ?SvgPicture.network("https://www.eplworld.com${ provider.recentMatche[index].matchInBoxModel[indexx].awayTeamLogo}", semanticsLabel: 'Acme Logo')
                                                                      : Image.network("https://www.eplworld.com${ provider.recentMatche[index].matchInBoxModel[indexx].awayTeamLogo}")
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 5,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*.4,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              provider.recentMatche[index].matchInBoxModel[indexx].awayTeamName,
                                                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
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
                  }),
            ],
              );
        },
      ),
    );
  }
}
