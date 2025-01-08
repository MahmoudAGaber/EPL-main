
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epl/presentation/league/screens/homeLeague.dart';
import 'package:epl/presentation/team/screens/teamHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'favouriteNotifiaction.dart';
import 'favouriteSelection.dart';



class FavouriteHome extends StatefulWidget {
  final String? tag;

  const FavouriteHome({this.tag});

  @override
  _FavouriteHomeState createState() => _FavouriteHomeState();
}

class _FavouriteHomeState extends State<FavouriteHome>
    with SingleTickerProviderStateMixin {

  SearchController? controller;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }

  List<Widget> tabs = [
    Tab(child: Text('إختيارتي'),),
    Tab(child: Text('إشعارات'),)
  ];

  List<Widget> tabView = [
    FavouriteSelection(),
    FavouriteNotification()
  ];

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
              children: <Widget>[
                Text(
                  "المفضلة".tr,
                  style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white,fontSize: 20),
                )
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: DefaultTabController(
              length: 2,
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 60,
                child: TabBar(
                  controller: tabController,
                    indicatorColor: Colors.white,
                    tabs:tabs
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: tabView,
          controller: tabController,
        )
            /*
        GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
              controller.searchTextEditingController.clear();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    onTap: (){
                      searchIcon();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        height: 60,
                        child: TextFormField(
                          controller:
                          controller.searchTextEditingController,
/*
                              onChanged: (inputValue) {
                                controller.onChanged(inputValue);
                                return;
                                if (lastInputValue != inputValue) {
                                  lastInputValue = inputValue;
                                  context
                                      .read<TeamSearchBloc>()
                                      .add(TextChanged(text: inputValue));
                                }
                              },
*/
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  borderSide:
                                  BorderSide(color: Theme.of(context).buttonColor)),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              filled: true,
                              fillColor: Theme.of(context).buttonColor,
                              prefixIcon: Padding(
                                padding:
                                const EdgeInsets.only(bottom: 4),
                                child: IconButton(
                                  onPressed: (){
                                    //searchIcon();
                                  },
                                  icon:Icon(
                                      Icons.search,
                                      color: Theme.of(context).colorScheme.primaryVariant
                                  ),
                                ),
                              ),
                              hintText: "ابحث عن فريق",
                              hintStyle: Theme.of(context).textTheme.headline3.copyWith(fontSize: 15)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,right: 12,left: 12),
                  child: Text(
                    'اتابعهم',
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 260,
                    child: Obx(() {
                      final teams = favouriteController.favouriteTeams.value;
                      return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: teams.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemBuilder: (BuildContext context, index) {
                            final item = teams[index];
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (widget.tag == 'الفرق') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider<
                                                        EachTeamViewModel>(
                                                    create: (_) =>
                                                        EachTeamViewModel(),
                                                    child: team(
                                                      url: item.teamBasicDataModel.url,
                                                    ))));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider<
                                                        EachLeagueViewModel>(
                                                    create: (_) =>
                                                        EachLeagueViewModel(),
                                                    child: league(
                                                        url: item
                                                            .teamBasicDataModel
                                                            .url))));
                                  }
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 45,
                                            height: 45,
                                            child: CachedNetworkImage(
                                              imageUrl: item.teamBasicDataModel
                                                  .image.hostedFile,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            item.teamBasicDataModel.text,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Vazirmatn',
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          });
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16,left: 12,right: 12),
                  child: Text(
                    'مقترحة',
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                ),
                Obx(
                      () {
                    final state = controller.teamSearchState.value;
                    print('state');
                    if (state is SearchStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is SearchStateSuccess) {
                      final data = state.data;

                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          final item = data[index];
                          final teamBasicDataModel = data[index].teamBasicDataModel;
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: GestureDetector(
                              onTap: () {
                                if (widget.tag == 'الفرق') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider<
                                                  EachTeamViewModel>(
                                                  create: (_) =>
                                                      EachTeamViewModel(),
                                                  child: team(
                                                    url: teamBasicDataModel.url,
                                                  ))));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider<
                                                  EachLeagueViewModel>(
                                                  create: (_) =>
                                                      EachLeagueViewModel(),
                                                  child: league(
                                                      url: teamBasicDataModel
                                                          .url))));
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                child: Container(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 35,
                                                  height: 35,
                                                  child: CachedNetworkImage(
                                                    imageUrl: teamBasicDataModel
                                                        .image.hostedFile,
                                                  )),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  teamBasicDataModel.text,
                                                  style:Theme.of(context).textTheme.bodyMedium.copyWith(fontSize: 13)
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 20),
                                          child: Builder(builder: (contextt) {
                                            return InkWell(
                                              onTap: () {
                                                favouriteController
                                                    .toggleFavourite(index);
/*
                                                    context
                                                        .read<TeamSearchBloc>()
                                                        .add(ToggleFavourite(
                                                            index));
*/
                                              },
                                              child: Container(
                                                width: 45,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15)),
                                                child: Center(
                                                    child: Text(
                                                      item.isFavourite
                                                          ? 'الغاء'
                                                          : 'تابع',
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                              .primaryColor,
                                                          fontFamily: 'Vazirmatn',
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    )),
                                              ),
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    if (state is SearchStateError) {
                      return Center(
                        child: Text('لا يوجد نتائج'),
                      );
                    }
                    return Center(
                      child: Text('ابدأ بالبحث الآن',style: Theme.of(context).textTheme.bodyMedium.copyWith(fontSize: 13),),
                    );
                  },
                ),

                SizedBox(
                  height: 400,
                )
              ],
            ),
          ),
        ),

             */
      ),
    );
  }

  searchIcon() {
    //List<SearchResponseModel> searchItems=[];
    TextEditingController search = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                insetPadding:
                EdgeInsets.only(top: 55, right: 12, left: 12, bottom: 155),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.primaryContainer
                          ),
                          onPressed: () {
                           // provider.getDataSearch('1');
                            Navigator.pop(context);
                            //controller.searchTextEditingController.clear();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              /*
                              provider.searchItems
                                  .where((element) => element.text
                                  .toLowerCase()
                                  .contains(value))
                                  .toList();
                              provider.getDataSearch(value);

                               */
                            },
                           // controller: controller.searchTextEditingController,
                            textCapitalization:
                            TextCapitalization.sentences,
                            decoration: InputDecoration.collapsed(
                                hintText:
                                "البحث عن الفرق،المقابلات،اللاعبين،الاخبار"
                                    .tr,
                                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 17)
                            ),
                          ),
                        ),
                      ],
                    ),
              ListView.builder(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    if (widget.tag == 'الفرق') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeTeam(
                                                    teamId:"",
                                                  )));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>LeagueHome(leagueName: "")));
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 35,
                                                    height: 35,
                                                    child: CachedNetworkImage(imageUrl: '',)),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text("text",
                                                    style:Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13)
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20),
                                            child: Builder(builder: (contextt) {
                                              return InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: 45,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                                  child: Center(
                                                      child: Text('تابع',
                                                        style: TextStyle(
                                                            color: Theme.of(context)
                                                                .primaryColor,
                                                            fontFamily: 'Vazirmatn',
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
              )
                  ],
                ),
              );
            },
          );
        });
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
                                  fontFamily: 'Vazirmatn',
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
                                  fontFamily: 'Vazirmatn',
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
                                  fontFamily: 'Vazirmatn',
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
    List<Widget> list = [];
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
