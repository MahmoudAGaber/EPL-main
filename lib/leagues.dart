import 'package:arseli/Provider/LeaguesViewModel.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'EachLeague/eachLeague.dart';
import 'More.dart';

class Leagues extends StatefulWidget {
  @override
  _LeaguesState createState() => _LeaguesState();
}

TextStyle content = TextStyle(fontSize: 14);
TextStyle _textStyletitle = TextStyle(fontSize: 20);

class _LeaguesState extends State<Leagues> with SingleTickerProviderStateMixin {
  LeaguesViewModel leaguesViewModel;
  TabController tabController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      leaguesViewModel = Provider.of(context, listen: false);
      leaguesViewModel.getDataLeagues();
    });
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  bool isSwitched = false;

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
              title: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Row(
                  children:<Widget>[
                    Text('بطولات',style: TextStyle(color: Colors.white),)
                  ],),
              )
          ),
          /*
          drawer: Drawer(
            child: More(),
          ),
          
           */
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Consumer<LeaguesViewModel>(
              builder: (context,provider,child){
                return provider.loadingLeagues
                    ?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
                    :ListView(
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
                                hintText: "ابحث عن البطولة",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('اتابعهم',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                    Text('تعديل',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColor),),
                                  ],)
                            ),
                            Divider(),
                            ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (widget, index) {
                                return  GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 35,
                                            height: 30,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: Image.asset("assets/12.jpg"))
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'الدوري الاسباني',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              padding: EdgeInsets.symmetric(vertical: 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 15,left: 15,top: 10),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('مقترحة',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                  Icon(Icons.clear,color: Colors.grey,size: 20,)
                                ],)
                          ),
                          Divider(),
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            itemBuilder: (widget, index) {
                              return  GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: 35,
                                              height: 30,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.asset("assets/12.jpg"))
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'الدوري الاسباني',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          width: 45,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Center(child: Text('متابعة',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 12,fontWeight: FontWeight.bold),)),
                                        ),)
                                    ],
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.symmetric(vertical: 5),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 8),
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: provider.responseModelLeagues.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  initiallyExpanded: true,
                                  title: GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 30,
                                            height: 30,
                                            child:  provider.responseModelLeagues[index].countryImage.endsWith('svg')
                                                ?ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: SvgPicture.network("https://www.eplworld.com/${provider.responseModelLeagues[index].countryImage}",semanticsLabel: 'Acme Logo',fit: BoxFit.cover,))
                                                :Image.network("https://www.eplworld.com${provider.responseModelLeagues[index].countryImage}")),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          provider.responseModelLeagues[index].name,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  children: [
                                    ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: provider.responseModelLeagues[index].Tournaments.length,
                                      itemBuilder: (widget, indexx) {
                                        return  GestureDetector(
                                          onTap: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context)=> ChangeNotifierProvider<EachLeagueViewModel>(
                                                    create: (_)=>EachLeagueViewModel(),
                                                    child: EachLeague(
                                                      url:"/tournaments/${provider.responseModelLeagues[index].Tournaments[indexx].url}",
                                                    ))));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 35,
                                                    height: 30,
                                                    child: provider.responseModelLeagues[index].Tournaments[indexx].LogoImage.endsWith('svg')
                                                        ?ClipRRect(
                                                        borderRadius: BorderRadius.circular(50),
                                                        child: SvgPicture.network("https://www.eplworld.com/${provider.responseModelLeagues[index].Tournaments[indexx].LogoImage}",semanticsLabel: 'Acme Logo',fit: BoxFit.cover,))
                                                        :Image.network("https://www.eplworld.com${provider.responseModelLeagues[index].Tournaments[indexx].LogoImage}")),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  provider.responseModelLeagues[index].Tournaments[indexx].name,
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                );
              },
            ),
          ),

        ));
  }
}
