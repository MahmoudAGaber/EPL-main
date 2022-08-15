import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Postions extends StatefulWidget {
  String url;
  Postions({this.url});
  @override
  _PostionsState createState() => _PostionsState();
}

TextStyle tapbar = TextStyle(
  fontSize: 13,
);
TextStyle headline = TextStyle(fontSize: 11, fontWeight: FontWeight.w600);
TextStyle headline2 = TextStyle(fontSize: 13.5, color: Colors.grey);
TextStyle content = TextStyle(
  fontSize: 13.5,
);

class _PostionsState extends State<Postions> {
  EachLeagueViewModel oneLeagueViewModel;
  List dropList;
  String selectedItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      oneLeagueViewModel = Provider.of(context, listen: false);
      oneLeagueViewModel.getTables(widget.url, 'tables',);
      dropList = oneLeagueViewModel.dropsTableRows;
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   // print("hello  ${widget.tournaments.url}");
    return SingleChildScrollView(
      child: Consumer<EachLeagueViewModel>(
        builder: (context, provider, child) {
          selectedItem = provider.calName.toString();
          return provider.loadingPositions
              ?Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),),
          )
              : Column(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: selectedItem,
                      isExpanded: true,
                      menuMaxHeight: 300,
                      items: provider.dropsTableRows.map((String value) {
                        return DropdownMenuItem<String>(
                          onTap: (){
                            provider.dropTableRowsList.forEach((element) {
                              if(value == element.text){
                                provider.getTables(widget.url, "tables/${element.value}");
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
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.42,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "#",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "فريق".tr,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.34,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 3, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "ل".tr,
                                          style: headline2,
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          "ف".tr,
                                          style: headline2,
                                        ),
                                        SizedBox(
                                          width: 22,
                                        ),
                                        Text(
                                          "ت".tr,
                                          style: headline2,
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          "خ".tr,
                                          style: headline2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.24,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 27,
                                      ),
                                      Text(
                                        "-/+",
                                        style: headline2,
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "ف أ".tr,
                                        style: headline2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemCount: provider.tablesModelList == null?0: provider.tablesModelList[0].list[0].tableModel.length,
                        itemBuilder: (BuildContext context, index) {
                          return Stack(
                            children: [
                              Container(
                                child: Column(children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder:(context)=>  ChangeNotifierProvider<EachTeamViewModel>(
                                                  create: (_) => EachTeamViewModel(),
                                                  child: EachTeam(
                                                    url: provider.tablesModelList[0].list[0].tableModel[index].link,
                                                    id: provider.tablesModelList[0].list[0].tableModel[index].id,)
                                              ))
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text((provider.tablesModelList[0].list[0].tableModel[index].serial).toString()),
                                                  ],),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Container(
                                                          width: 40,
                                                          height: 28,
                                                          child: Image.network('https://www.eplworld.com${provider.tablesModelList[0].list[0].tableModel[index].logo}')),
                                                    ),
                                                  ],)
                                              ],
                                            ),
                                            Flexible(
                                                flex:4,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(provider.tablesModelList[0].list[0].tableModel[index].name,style: content,)
                                                      ],)
                                                  ],
                                                )),

                                            Flexible(
                                              flex:6,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(provider.tablesModelList[0].list[0].tableModel[index].colL.toString(), style: content,),
                                                    ],),

                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(provider.tablesModelList[0].list[0].tableModel[index].colF.toString(), style: content,),
                                                    ],),

                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(provider.tablesModelList[0].list[0].tableModel[index].colT.toString(), style: content,),
                                                    ],),

                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(provider.tablesModelList[0].list[0].tableModel[index].colK.toString(), style: content,),
                                                    ],),

                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(provider.tablesModelList[0].list[0].tableModel[index].colFA, style: content,),
                                                    ],),

                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(provider.tablesModelList[0].list[0].tableModel[index].colN.toString(), style: content,)
                                                    ],),

                                                ],
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 2.0,
                                    color: Colors.grey,
                                  )
                                ]),
                              ),
                              Container(
                                  width: 4,
                                  height:35,
                                  color:provider.tablesModelList[0].list[0].tableModel[index].tag == 'green'
                                      ?Colors.green
                                      :provider.tablesModelList[0].list[0].tableModel[index].tag == 'blue'
                                      ? Colors.blue
                                      :provider.tablesModelList[0].list[0].tableModel[index].tag == 'red'
                                      ?Colors.red
                                      :provider.tablesModelList[0].list[0].tableModel[index].tag == 'yellow'
                                      ?Colors.yellow
                                      :null


                              ),
                            ],
                          );
                        }),
                    SizedBox(height: 10,),
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.tablesModelList==null?0:provider.tablesModelList[0].list[0].footermodel.length,
                        itemBuilder:(context,index){
                          return Padding(
                            padding: const EdgeInsets.only(right: 10,bottom: 15,left: 10,top: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color:provider.tablesModelList[0].list[0].footermodel[index].color == 'green'
                                          ?Colors.green
                                          :provider.tablesModelList[0].list[0].footermodel[index].color == 'blue'
                                          ? Colors.blue
                                          :provider.tablesModelList[0].list[0].footermodel[index].color == 'red'
                                          ?Colors.red
                                          :provider.tablesModelList[0].list[0].footermodel[index].color == 'yellow'
                                          ?Colors.yellow
                                          :null
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(provider.tablesModelList[0].list[0].footermodel[index].text)
                              ],),
                          );
                        } )
                  ],
                );
        },
      ),
    );
  }
}
