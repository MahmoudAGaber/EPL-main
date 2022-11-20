import 'dart:io';

import 'package:arseli/Data/local_data_sources/favourite/favourite_team_local_data_source.dart';
import 'package:arseli/Data/remote_data_sources/teams/teams_remote_data_source.dart';
import 'package:arseli/Data/repos/team_repo.dart';
import 'package:arseli/EachTeam/eachTeam.dart';
import 'package:arseli/Provider/EachLeagueViewModel.dart';
import 'package:arseli/Provider/EachTeamViewModel.dart';
import 'package:arseli/Provider/LeaguesViewModel.dart';
import 'package:arseli/controllers/ControllerFavorites.dart';
import 'package:arseli/controllers/search_controller.dart';
import 'package:arseli/injection.dart';
import 'package:arseli/states/team_search_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EachLeague/eachLeague.dart';
import 'Models/token.dart';
import 'Provider/TokenViewModel.dart';

class Leagues extends StatefulWidget {
  final String tag;
  const Leagues({Key key, this.tag}) : super(key: key);

  @override
  _LeaguesState createState() => _LeaguesState();
}

TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 14);
TextStyle _textStyletitle = TextStyle(fontFamily: 'Vazirmatn', fontSize: 20);

class _LeaguesState extends State<Leagues> with SingleTickerProviderStateMixin {
  LeaguesViewModel leaguesViewModel;
  TabController tabController;
  SearchController controller;
  FavoritesController favouriteController;

  Token token = Token();
  final String defaultLocale = Platform.localeName;
  getToken() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      token.id = androidInfo.id;
      token.deviceName = androidInfo.device;
      token.appVersion = androidInfo.version.release;
      token.deviceType = "Android";
      token.deviceModel = androidInfo.model;
      token.systemVersion = Platform.operatingSystemVersion;
      token.defaultLocale = defaultLocale;
      token.timeZone = DateTime.now().timeZoneName;
      token.oneSignalToken = "";
      if (token.id != null) {
        saveToken(token);
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      token.id = iosInfo.identifierForVendor;
      token.deviceName = iosInfo.name;
      token.appVersion = iosInfo.systemVersion;
      token.deviceType = "IOS";
      token.deviceModel = iosInfo.model;
      token.systemVersion = Platform.operatingSystemVersion;
      token.defaultLocale = defaultLocale;
      token.timeZone = DateTime.now().timeZoneName;
      token.oneSignalToken = "";
      if (token.id != null) {
        saveToken(token);
      }
    }
  }

  saveToken(Token token) async {
    var prefs = await SharedPreferences.getInstance();
    var userPref = prefs.setString("DeviceID", token.id);
    var res = await Provider.of<TokenViewModel>(context, listen: false).sendToken(token);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      leaguesViewModel = Provider.of(context, listen: false);
      leaguesViewModel.getDataLeagues();
      getToken();
    });
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    final repo = TeamRepo(
        TeamsRemoteDataSource(Get.find()),
        FavouriteTeamLocalDataSource(
            Injection.getIt.get<GetStorage>(), widget.tag));
    controller = Get.put(SearchController(repo), tag: widget.tag);
    Get.put(FavoritesController(repo, widget.tag),
        permanent: true, tag: widget.tag);
    favouriteController = Get.find<FavoritesController>(tag: widget.tag);
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
                  children: <Widget>[
                    Text(
                      'بطولات',
                      style: TextStyle(
                          fontFamily: 'Vazirmatn', color: Colors.white,fontSize: 20),
                    )
                  ],
                ),
              )),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
                controller.searchTextEditingController.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer<LeaguesViewModel>(
                builder: (context, provider, child) {
                  return provider.loadingLeagues
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
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
                                          child: Icon(
                                            Icons.search,
                                            color: Theme.of(context).colorScheme.primaryVariant
                                          ),
                                        ),
                                        hintText: "ابحث عن بطوله",
                                        hintStyle: Theme.of(context).textTheme.headline3.copyWith(fontSize: 15)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'اتابعهم',
                                              style: Theme.of(context).textTheme.headline2
                                          ),
                                          // Text(
                                          //   'تعديل',
                                          //   style: TextStyle(
                                          //       fontFamily: 'Vazirmatn',
                                          //       fontSize: 13,
                                          //       fontWeight: FontWeight.w600,
                                          //       color: Theme.of(context)
                                          //           .primaryColor),
                                          // ),
                                        ],
                                      )),
                                  children: [
                                    Obx(() {
                                      final teams = favouriteController
                                          .favouriteTeams.value;
                                      return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: teams.length,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context, index) {
                                            final item = teams[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (widget.tag == 'الفرق') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ChangeNotifierProvider<
                                                                    EachTeamViewModel>(
                                                                create: (_) =>
                                                                    EachTeamViewModel(),
                                                                child:
                                                                    EachTeam(
                                                                  url: item
                                                                      .teamBasicDataModel
                                                                      .url,
                                                                ))));
                                                  } else if(widget.tag == 'البطولات') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ChangeNotifierProvider<
                                                                    EachLeagueViewModel>(
                                                                create: (_) =>
                                                                    EachLeagueViewModel(),
                                                                child: EachLeague(
                                                                    url: item
                                                                        .teamBasicDataModel
                                                                        .url))));
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                  children: [
                                                    Container(
                                                        width: 30,
                                                        height: 30,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: item
                                                              .teamBasicDataModel
                                                              .image
                                                              .hostedFile,
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: Text(
                                                        item.teamBasicDataModel
                                                            .text,
                                                        textAlign:
                                                            TextAlign
                                                                .center,
                                                        style: Theme.of(context).textTheme.bodyText1
                                                        ),
                                                      ),

                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'مقترحة',
                                              style: Theme.of(context).textTheme.headline2
                                          ),
                                          /*
                                          Icon(
                                            Icons.clear,
                                            color: Colors.grey,
                                            size: 20,
                                          )

                                           */
                                        ],
                                      )),
                                  Divider(),
                                  Obx(
                                    () {
                                      final state =
                                          controller.teamSearchState.value;
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
                                            final teamBasicDataModel =
                                                data[index].teamBasicDataModel;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
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
                                                                    child:
                                                                        EachTeam(
                                                                      url: teamBasicDataModel
                                                                          .url,
                                                                    ))));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ChangeNotifierProvider<
                                                                    EachLeagueViewModel>(
                                                                create: (_) =>
                                                                    EachLeagueViewModel(),
                                                                child: EachLeague(
                                                                    url: teamBasicDataModel.url))));
                                                  }
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: Container(
                                                    height: 50,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    width: 35,
                                                                    height: 35,
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl: teamBasicDataModel
                                                                          .image
                                                                          .hostedFile,
                                                                    )),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  teamBasicDataModel
                                                                      .text,
                                                                    style: Theme.of(context).textTheme.headline2
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20),
                                                            child: Builder(
                                                                builder:
                                                                    (contextt) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  favouriteController
                                                                      .toggleFavourite(
                                                                          index);
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
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                  child: Center(
                                                                      child: Text(
                                                                    item.isFavourite
                                                                        ? 'الغاء'
                                                                        : 'تابع',
                                                                    style: TextStyle(
                                                                        color: Theme.of(
                                                                                context)
                                                                            .primaryColor,
                                                                        fontFamily:
                                                                            'Vazirmatn',
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Text('ابدأ بالبحث الآن',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13),),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 8),
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: provider.responseModelLeagues.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4,bottom: 4),
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                                      child: provider.responseModelLeagues[index].countryImage.endsWith('svg')
                                                          ? ClipRRect(
                                                              borderRadius: BorderRadius.circular(50),
                                                              child: SvgPicture.network(
                                                                "https://www.eplworld.com/${provider.responseModelLeagues[index].countryImage}",
                                                                semanticsLabel: 'Acme Logo',
                                                                fit: BoxFit.cover,
                                                              ))
                                                          : Image.network(
                                                              "https://www.eplworld.com${provider.responseModelLeagues[index].countryImage}")),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    provider.responseModelLeagues[index].name,
                                                      style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16)
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
                                                    .responseModelLeagues[index]
                                                    .Tournaments
                                                    .length,
                                                itemBuilder: (widget, indexx) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChangeNotifierProvider<
                                                                          EachLeagueViewModel>(
                                                                      create: (_) =>
                                                                          EachLeagueViewModel(),
                                                                      child:
                                                                          EachLeague(
                                                                        url:
                                                                            "/tournaments/${provider.responseModelLeagues[index].Tournaments[indexx].url}",
                                                                      ))));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: 35,
                                                              height: 30,
                                                              child: provider
                                                                      .responseModelLeagues[
                                                                          index]
                                                                      .Tournaments[
                                                                          indexx]
                                                                      .LogoImage
                                                                      .endsWith(
                                                                          'svg')
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  50),
                                                                      child: SvgPicture
                                                                          .network(
                                                                        "https://www.eplworld.com/${provider.responseModelLeagues[index].Tournaments[indexx].LogoImage}",
                                                                        semanticsLabel:
                                                                            'Acme Logo',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ))
                                                                  : Image.network(
                                                                      "https://www.eplworld.com${provider.responseModelLeagues[index].Tournaments[indexx].LogoImage}")),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            provider
                                                                .responseModelLeagues[
                                                                    index]
                                                                .Tournaments[indexx]
                                                                .name,
                                                              style: Theme.of(context).textTheme.headline2
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                              )
                                            ],
                                          ),
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
          ),
        ));
  }
}
