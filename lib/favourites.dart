import 'package:arseli/Data/local_data_sources/favourite/favourite_team_local_data_source.dart';
import 'package:arseli/Data/remote_data_sources/teams/teams_remote_data_source.dart';
import 'package:arseli/EachLeague/eachLeague.dart';
import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/states/team_search_state.dart';
import 'package:arseli/controllers/ControllerFavorites.dart';
import 'package:arseli/controllers/search_controller.dart';
import 'package:arseli/injection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'Data/repos/team_repo.dart';

class Favourites extends StatefulWidget {
  final String tag;

  const Favourites({Key key, this.tag}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites>
    with SingleTickerProviderStateMixin {
  SearchController controller;
  FavoritesController favouriteController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final repo = TeamRepo(
        TeamsRemoteDataSource(Get.find()),
        FavouriteTeamLocalDataSource(
            Injection.getIt.get<GetStorage>(),
            widget.tag));
    controller = Get.put(SearchController(repo), tag: widget.tag);
    Get.put(FavoritesController(repo, widget.tag),
        permanent: true, tag: widget.tag);
    favouriteController = Get.find<FavoritesController>(tag: widget.tag);


/*
    Get.put(ControllerFavorites(Injection.getIt.get<TeamRepo>()),
        permanent: true, tag: 'leagues');
*/
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
                style: TextStyle(color: Colors.white, fontFamily: 'Vazirmatn',fontSize: 20),
              )
            ],
          ),
        ),
        body: Padding(
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
                  child: AbsorbPointer(
                    absorbing: true,
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
                                    searchIcon();
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,right: 12,left: 12),
                child: Text(
                  'اتابعهم',
                  style: Theme.of(context).textTheme.headline2
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
                                                  child: EachTeam(
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
                                                  child: EachLeague(
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
                  style: Theme.of(context).textTheme.headline2
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
                                                child: EachTeam(
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
                                                child: EachLeague(
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
                                                style:Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13)
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
                    child: Text('ابدأ بالبحث الآن',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),),
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
                              color: Theme.of(context).colorScheme.primaryVariant
                          ),
                          onPressed: () {
                           // provider.getDataSearch('1');
                            Navigator.pop(context);
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
                            controller: controller.searchTextEditingController,
                            textCapitalization:
                            TextCapitalization.sentences,
                            decoration: InputDecoration.collapsed(
                                hintText:
                                "البحث عن الفرق،المقابلات،اللاعبين،الاخبار"
                                    .tr,
                                hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 17)
                            ),
                          ),
                        ),
                      ],
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
                                                      child: EachTeam(
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
                                                      child: EachLeague(
                                                          url: teamBasicDataModel
                                                              .url))));
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
                                                    child: CachedNetworkImage(
                                                      imageUrl: teamBasicDataModel
                                                          .image.hostedFile,
                                                    )),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                    teamBasicDataModel.text,
                                                    style:Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13)
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
                          child: Text('ابدأ بالبحث الآن',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),),
                        );
                      },
                    ),
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
// import 'package:arseli/Provider/EachLeagueViewModel.dart';
// import 'package:arseli/Provider/LeaguesViewModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import 'EachLeague/eachLeague.dart';

// class Leagues extends StatefulWidget {
//   @override
//   _LeaguesState createState() => _LeaguesState();
// }

// TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 14);
// TextStyle _textStyletitle = TextStyle(fontFamily: 'Vazirmatn', fontSize: 20);

// class _LeaguesState extends State<Leagues> with SingleTickerProviderStateMixin {
//   LeaguesViewModel leaguesViewModel;
//   TabController tabController;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       leaguesViewModel = Provider.of(context, listen: false);
//       leaguesViewModel.getDataLeagues();
//     });
//     super.initState();
//     tabController = new TabController(length: 3, vsync: this);
//   }

//   @override
//   bool isSwitched = false;

//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           appBar: AppBar(
//               iconTheme: IconThemeData(color: Colors.white),
//               backgroundColor: Theme.of(context).primaryColor,
//               title: Padding(
//                 padding: const EdgeInsets.only(right: 0),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       'بطولات',
//                       style: TextStyle(
//                           fontFamily: 'Vazirmatn', color: Colors.white),
//                     )
//                   ],
//                 ),
//               )),
//           body: Padding(
//             padding: const EdgeInsets.all(8),
//             child: Consumer<LeaguesViewModel>(
//               builder: (context, provider, child) {
//                 return provider.loadingLeagues
//                     ? Center(
//                         child: CircularProgressIndicator(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       )
//                     : ListView(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: Container(
//                                 height: 60,
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       focusedBorder: InputBorder.none,
//                                       enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           borderSide:
//                                               BorderSide(color: Colors.white)),
//                                       errorBorder: InputBorder.none,
//                                       disabledBorder: InputBorder.none,
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       prefixIcon: Padding(
//                                         padding:
//                                             const EdgeInsets.only(bottom: 4),
//                                         child: Icon(
//                                           Icons.search,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       hintText: "ابحث عن البطولة",
//                                       hintStyle: TextStyle(
//                                           fontFamily: 'Vazirmatn',
//                                           color: Colors.grey)),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Card(
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                       padding: const EdgeInsets.only(
//                                           right: 15, left: 15, top: 10),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'اتابعهم',
//                                             style: TextStyle(
//                                                 fontFamily: 'Vazirmatn',
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                           Text(
//                                             'تعديل',
//                                             style: TextStyle(
//                                                 fontFamily: 'Vazirmatn',
//                                                 fontSize: 13,
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Theme.of(context)
//                                                     .primaryColor),
//                                           ),
//                                         ],
//                                       )),
//                                   Divider(),
//                                   ListView.builder(
//                                     physics: ClampingScrollPhysics(),
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.vertical,
//                                     itemCount: 5,
//                                     itemBuilder: (widget, index) {
//                                       return GestureDetector(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Row(
//                                             children: [
//                                               Container(
//                                                   width: 35,
//                                                   height: 30,
//                                                   child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               50),
//                                                       child: Image.asset(
//                                                           "assets/12.jpg"))),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Text(
//                                                 'الدوري الاسباني',
//                                                 style: TextStyle(
//                                                     fontFamily: 'Vazirmatn',
//                                                     fontSize: 16),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Card(
//                             elevation: 2,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 15, left: 15, top: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           'مقترحة',
//                                           style: TextStyle(
//                                               fontFamily: 'Vazirmatn',
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                         Icon(
//                                           Icons.clear,
//                                           color: Colors.grey,
//                                           size: 20,
//                                         )
//                                       ],
//                                     )),
//                                 Divider(),
//                                 ListView.builder(
//                                   physics: ClampingScrollPhysics(),
//                                   shrinkWrap: true,
//                                   scrollDirection: Axis.vertical,
//                                   itemCount: 5,
//                                   itemBuilder: (widget, index) {
//                                     return GestureDetector(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(10.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                     width: 35,
//                                                     height: 30,
//                                                     child: ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(50),
//                                                         child: Image.asset(
//                                                             "assets/12.jpg"))),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Text(
//                                                   'الدوري الاسباني',
//                                                   style: TextStyle(
//                                                       fontFamily: 'Vazirmatn',
//                                                       fontSize: 16),
//                                                 ),
//                                               ],
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 10),
//                                               child: Container(
//                                                 width: 45,
//                                                 height: 20,
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.grey[200],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15)),
//                                                 child: Center(
//                                                     child: Text(
//                                                   'متابعة',
//                                                   style: TextStyle(
//                                                       fontFamily: 'Vazirmatn',
//                                                       color: Theme.of(context)
//                                                           .primaryColor,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 )),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   padding: EdgeInsets.symmetric(vertical: 5),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10, bottom: 8),
//                             child: ListView.builder(
//                                 physics: BouncingScrollPhysics(),
//                                 itemCount: provider.responseModelLeagues.length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   return Card(
//                                     elevation: 2,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Theme(
//                                       data: Theme.of(context).copyWith(
//                                           dividerColor: Colors.transparent),
//                                       child: ExpansionTile(
//                                         initiallyExpanded: true,
//                                         title: GestureDetector(
//                                           onTap: () {},
//                                           child: Row(
//                                             children: [
//                                               Container(
//                                                   width: 30,
//                                                   height: 30,
//                                                   child: provider
//                                                           .responseModelLeagues[
//                                                               index]
//                                                           .countryImage
//                                                           .endsWith('svg')
//                                                       ? ClipRRect(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(50),
//                                                           child: SvgPicture
//                                                               .network(
//                                                             "https://www.eplworld.com/${provider.responseModelLeagues[index].countryImage}",
//                                                             semanticsLabel:
//                                                                 'Acme Logo',
//                                                             fit: BoxFit.cover,
//                                                           ))
//                                                       : Image.network(
//                                                           "https://www.eplworld.com${provider.responseModelLeagues[index].countryImage}")),
//                                               SizedBox(
//                                                 width: 15,
//                                               ),
//                                               Text(
//                                                 provider
//                                                     .responseModelLeagues[index]
//                                                     .name,
//                                                 style: TextStyle(
//                                                     fontFamily: 'Vazirmatn',
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         children: [
//                                           ListView.builder(
//                                             physics: ClampingScrollPhysics(),
//                                             shrinkWrap: true,
//                                             scrollDirection: Axis.vertical,
//                                             itemCount: provider
//                                                 .responseModelLeagues[index]
//                                                 .Tournaments
//                                                 .length,
//                                             itemBuilder: (widget, indexx) {
//                                               return GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               ChangeNotifierProvider<
//                                                                       EachLeagueViewModel>(
//                                                                   create: (_) =>
//                                                                       EachLeagueViewModel(),
//                                                                   child:
//                                                                       EachLeague(
//                                                                     url:
//                                                                         "/tournaments/${provider.responseModelLeagues[index].Tournaments[indexx].url}",
//                                                                   ))));
//                                                 },
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       10.0),
//                                                   child: Row(
//                                                     children: [
//                                                       Container(
//                                                           width: 35,
//                                                           height: 30,
//                                                           child: provider
//                                                                   .responseModelLeagues[
//                                                                       index]
//                                                                   .Tournaments[
//                                                                       indexx]
//                                                                   .LogoImage
//                                                                   .endsWith(
//                                                                       'svg')
//                                                               ? ClipRRect(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               50),
//                                                                   child: SvgPicture
//                                                                       .network(
//                                                                     "https://www.eplworld.com/${provider.responseModelLeagues[index].Tournaments[indexx].LogoImage}",
//                                                                     semanticsLabel:
//                                                                         'Acme Logo',
//                                                                     fit: BoxFit
//                                                                         .cover,
//                                                                   ))
//                                                               : Image.network(
//                                                                   "https://www.eplworld.com${provider.responseModelLeagues[index].Tournaments[indexx].LogoImage}")),
//                                                       SizedBox(
//                                                         width: 10,
//                                                       ),
//                                                       Text(
//                                                         provider
//                                                             .responseModelLeagues[
//                                                                 index]
//                                                             .Tournaments[indexx]
//                                                             .name,
//                                                         style: TextStyle(
//                                                             fontFamily:
//                                                                 'Vazirmatn',
//                                                             fontSize: 16),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 5),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           )
//                         ],
//                       );
//               },
//             ),
//           ),
//         ));
//   }
// }