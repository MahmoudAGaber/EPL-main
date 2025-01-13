
import 'package:epl/Data/StateModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epl/shared/Views/custom/custom_imageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Utils/Constants.dart';
import '../../../shared/helper/countryShortName.dart';
import '../../league/screens/homeLeague.dart';
import '../provider/CompetitionViewModel.dart';

class Competition extends ConsumerStatefulWidget {
  final String tag;
  const Competition({required this.tag});

  @override
  _CompetitionState createState() => _CompetitionState();
}

TextStyle content = TextStyle(fontFamily: 'Vazirmatn', fontSize: 14);
TextStyle _textStyletitle = TextStyle(fontFamily: 'Vazirmatn', fontSize: 20);

class _CompetitionState extends ConsumerState<Competition> with SingleTickerProviderStateMixin {
  TabController? tabController;



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //ref.read(TopCompetitionProvider.notifier).getTopCompetition();
      //ref.read(CompetitionProvider.notifier).getCompetition();
    });
    super.initState();
    tabController = new TabController(length: 3, vsync: this);

  }

  @override
  bool isSwitched = false;

  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var topCompetition = ref.watch(TopCompetitionProvider);
    var competition = ref.watch(CompetitionProvider);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
              title: Row(
                children: <Widget>[
                  Text('بطولات',
                    style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white,fontSize: 20),
                  )
                ],
              )),
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.focusedChild?.unfocus();
                  //controller.searchTextEditingController.clear();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    topCompetition.handelState(
                      onLoading: (state)=> Center(child: SizedBox(),),
                      onSuccess: (state)=> Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: topCompetition.data!.length,
                          itemBuilder: (context, index) {
                            var topLeague = topCompetition.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) =>
                                    LeagueHome(
                                      leagueName: topLeague.league.name,
                                      leagueId: topLeague.league.id,
                                      logo: topLeague.league.logo,)
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CustomImage(imgUrl: topLeague.league.logo,)),
                                    SizedBox(width: 10,),
                                    Text(topLeague.league.name, style: Theme.of(context).textTheme.bodyMedium!
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          padding: EdgeInsets.symmetric(
                              vertical: 5),
                        ),
                      ),
                      onFailure: (state)=> Center(child: Text("FAILD"),),
                    ),
                    competition.handelState(
                      onLoading: (state)=> Center(child: SizedBox(),),
                      onSuccess: (state)=> ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 10),
                          //   child: Card(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8)),
                          //     child: Container(
                          //       height: 60,
                          //       child: TextFormField(
                          //                 //controller: controller.searchTextEditingController,
                          //            onChanged: (value) {
                          //
                          //                 },
                          //                 decoration: InputDecoration(
                          //                     border: InputBorder.none,
                          //                     focusedBorder: InputBorder.none,
                          //                     enabledBorder: OutlineInputBorder(
                          //                         borderRadius: BorderRadius.circular(8),
                          //                         borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                          //                     errorBorder: InputBorder.none,
                          //                     disabledBorder: InputBorder.none,
                          //                     filled: true,
                          //                     fillColor: Theme.of(context).primaryColor,
                          //                     prefixIcon: Padding(
                          //                       padding: const EdgeInsets.only(bottom: 4),
                          //                       child: Icon(
                          //                         Icons.search,
                          //                         color: Theme.of(context).colorScheme.primary
                          //                       ),
                          //                     ),
                          //                     hintText: "ابحث عن بطوله",
                          //                     hintStyle: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 15)),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                                    //                             Padding(
                                    //                               padding: const EdgeInsets.only(top: 10),
                                    //                               child: Card(
                                    //                                 elevation: 2,
                                    //                                 shape: RoundedRectangleBorder(
                                    //                                     borderRadius: BorderRadius.circular(10)),
                                    //                                 child: ExpansionTile(
                                    //                                   initiallyExpanded: true,
                                    //                                   title: Padding(
                                    //                                       padding: const EdgeInsets.only(
                                    //                                           right: 15, left: 15, top: 10),
                                    //                                       child: Row(
                                    //                                         mainAxisAlignment:
                                    //                                         MainAxisAlignment.spaceBetween,
                                    //                                         children: [
                                    //                                           Text('اتابعهم',
                                    //                                               style: Theme.of(context).textTheme.bodyMedium),
                                    //                                           // Text(
                                    //                                           //   'تعديل',
                                    //                                           //   style: TextStyle(
                                    //                                           //       fontFamily: 'Vazirmatn',
                                    //                                           //       fontSize: 13,
                                    //                                           //       fontWeight: FontWeight.w600,
                                    //                                           //       color: Theme.of(context)
                                    //                                           //           .primaryColor),
                                    //                                           // ),
                                    //                                         ],
                                    //                                       )),
                                    //                                   children: [
                                    //                                     Obx(() {
                                    //                                       final teams = favouriteController
                                    //                                           .favouriteTeams.value;
                                    //                                       return ListView.builder(
                                    //                                           scrollDirection: Axis.vertical,
                                    //                                           itemCount: teams.length,
                                    //                                           shrinkWrap: true,
                                    //                                           physics: NeverScrollableScrollPhysics(),
                                    //                                           itemBuilder: (BuildContext context, index) {
                                    //                                             final item = teams[index];
                                    //                                             return Padding(
                                    //                                               padding: const EdgeInsets.all(10.0),
                                    //                                               child: GestureDetector(
                                    //                                                 onTap: () {
                                    //                                                   if (widget.tag == 'الفرق') {
                                    //                                                     Navigator.push(
                                    //                                                         context,
                                    //                                                         MaterialPageRoute(
                                    //                                                             builder: (context) => ChangeNotifierProvider<
                                    //                                                                     EachTeamViewModel>(
                                    //                                                                 create: (_) =>
                                    //                                                                     EachTeamViewModel(),
                                    //                                                                 child:
                                    //                                                                     EachTeam(
                                    //                                                                   url: item
                                    //                                                                       .teamBasicDataModel
                                    //                                                                       .url,
                                    //                                                                 ))));
                                    //                                                   } else if(widget.tag == 'البطولات') {
                                    //                                                     Navigator.push(
                                    //                                                         context,
                                    //                                                         MaterialPageRoute(
                                    //                                                             builder: (context) => ChangeNotifierProvider<
                                    //                                                                     EachLeagueViewModel>(
                                    //                                                                 create: (_) =>
                                    //                                                                     EachLeagueViewModel(),
                                    //                                                                 child: EachLeague(
                                    //                                                                     url: item
                                    //                                                                         .teamBasicDataModel
                                    //                                                                         .url))));
                                    //                                                   }
                                    //                                                 },
                                    //                                                 child: Row(
                                    //                                                   mainAxisAlignment:
                                    //                                                       MainAxisAlignment
                                    //                                                           .start,
                                    //                                                   children: [
                                    //                                                     Container(
                                    //                                                         width: 30,
                                    //                                                         height: 30,
                                    //                                                         child:
                                    //                                                             CachedNetworkImage(
                                    //                                                           imageUrl: item
                                    //                                                               .teamBasicDataModel
                                    //                                                               .image
                                    //                                                               .hostedFile,
                                    //                                                         )),
                                    //                                                     Padding(
                                    //                                                       padding:
                                    //                                                           const EdgeInsets
                                    //                                                               .all(8.0),
                                    //                                                       child: Text(
                                    //                                                         item.teamBasicDataModel
                                    //                                                             .text,
                                    //                                                         textAlign:
                                    //                                                             TextAlign
                                    //                                                                 .center,
                                    //                                                         style: Theme.of(context).textTheme.bodyMedium
                                    //                                                         ),
                                    //                                                       ),
                                    //
                                    //                                                   ],
                                    //                                                 ),
                                    //                                               ),
                                    //                                             );
                                    //                                           });
                                    //                                     }),
                                    //                                   ],
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                             Card(
                                    //                               elevation: 2,
                                    //                               shape: RoundedRectangleBorder(
                                    //                                   borderRadius: BorderRadius.circular(10)),
                                    //                               child: Column(
                                    //                                 crossAxisAlignment: CrossAxisAlignment.start,
                                    //                                 children: [
                                    //                                   Padding(
                                    //                                       padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                                    //                                       child: Row(
                                    //                                         mainAxisAlignment:
                                    //                                             MainAxisAlignment.spaceBetween,
                                    //                                         children: [
                                    //                                           Text(
                                    //                                             'مقترحة',
                                    //                                               style: Theme.of(context).textTheme.bodyMedium
                                    //                                           ),
                                    //
                                    //                                         ],
                                    //                                       )),
                                    //                                   Divider(),
                                    //                                   Obx(
                                    //                                     () {
                                    //                                       final state =
                                    //                                           controller.teamSearchState.value;
                                    //                                       print('state');
                                    //                                       if (state is SearchStateLoading) {
                                    //                                         return Center(
                                    //                                           child: CircularProgressIndicator(),
                                    //                                         );
                                    //                                       }
                                    //                                       if (state is SearchStateSuccess) {
                                    //                                         final data = state.data;
                                    //
                                    //                                         return ListView.builder(
                                    //                                           physics: ClampingScrollPhysics(),
                                    //                                           scrollDirection: Axis.vertical,
                                    //                                           shrinkWrap: true,
                                    //                                           itemCount: data.length,
                                    //                                           itemBuilder: (_, index) {
                                    //                                             return Padding(
                                    //                                               padding:
                                    //                                                   const EdgeInsets.only(top: 6),
                                    //                                               child: GestureDetector(
                                    //                                                 onTap: () {},
                                    //                                                 child: Card(
                                    //                                                   shape: RoundedRectangleBorder(
                                    //                                                       borderRadius:
                                    //                                                           BorderRadius.circular(
                                    //                                                               6)),
                                    //                                                   child: Container(
                                    //                                                     height: 50,
                                    //                                                     child: Padding(
                                    //                                                       padding:
                                    //                                                           const EdgeInsets.all(
                                    //                                                               8.0),
                                    //                                                       child: Row(
                                    //                                                         mainAxisAlignment:
                                    //                                                             MainAxisAlignment
                                    //                                                                 .spaceBetween,
                                    //                                                         children: [
                                    //                                                           Container(
                                    //                                                             child: Row(
                                    //                                                               children: [
                                    //                                                                 Container(
                                    //                                                                     width: 35,
                                    //                                                                     height: 35,
                                    //                                                                     child: CachedNetworkImage(
                                    //                                                                       imageUrl: teamBasicDataModel
                                    //                                                                           .image
                                    //                                                                           .hostedFile,
                                    //                                                                     )),
                                    //                                                                 SizedBox(
                                    //                                                                   width: 4,
                                    //                                                                 ),
                                    //                                                                 Text(
                                    //                                                                   teamBasicDataModel
                                    //                                                                       .text,
                                    //                                                                     style: Theme.of(context).textTheme.bodyMedium
                                    //                                                                 )
                                    //                                                               ],
                                    //                                                             ),
                                    //                                                           ),
                                    //                                                           Padding(
                                    //                                                             padding:
                                    //                                                                 const EdgeInsets
                                    //                                                                         .only(
                                    //                                                                     left: 20),
                                    //                                                             child: Builder(
                                    //                                                                 builder:
                                    //                                                                     (contextt) {
                                    //                                                               return InkWell(
                                    //                                                                 onTap: () {
                                    //                                                                   favouriteController
                                    //                                                                       .toggleFavourite(
                                    //                                                                           index);
                                    // /*
                                    //                                                     context
                                    //                                                         .read<TeamSearchBloc>()
                                    //                                                         .add(ToggleFavourite(
                                    //                                                             index));
                                    // */
                                    //                                                                 },
                                    //                                                                 child: Container(
                                    //                                                                   width: 45,
                                    //                                                                   height: 20,
                                    //                                                                   decoration: BoxDecoration(
                                    //                                                                       color: Colors
                                    //                                                                               .grey[
                                    //                                                                           200],
                                    //                                                                       borderRadius:
                                    //                                                                           BorderRadius.circular(
                                    //                                                                               15)),
                                    //                                                                   child: Center(
                                    //                                                                       child: Text(
                                    //                                                                     item.isFavourite
                                    //                                                                         ? 'الغاء'
                                    //                                                                         : 'تابع',
                                    //                                                                     style: TextStyle(
                                    //                                                                         color: Theme.of(
                                    //                                                                                 context)
                                    //                                                                             .primaryColor,
                                    //                                                                         fontFamily:
                                    //                                                                             'Vazirmatn',
                                    //                                                                         fontSize:
                                    //                                                                             12,
                                    //                                                                         fontWeight:
                                    //                                                                             FontWeight
                                    //                                                                                 .bold),
                                    //                                                                   )),
                                    //                                                                 ),
                                    //                                                               );
                                    //                                                             }),
                                    //                                                           )
                                    //                                                         ],
                                    //                                                       ),
                                    //                                                     ),
                                    //                                                   ),
                                    //                                                 ),
                                    //                                               ),
                                    //                                             );
                                    //                                           },
                                    //                                         );
                                    //                                       }
                                    //                                       if (state is SearchStateError) {
                                    //                                         return Center(
                                    //                                           child: Text('لا يوجد نتائج'),
                                    //                                         );
                                    //                                       }
                                    //                                       return Center(
                                    //                                         child: Padding(
                                    //                                           padding: const EdgeInsets.only(top: 10),
                                    //                                           child: Text('ابدأ بالبحث الآن',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),),
                                    //                                         ),
                                    //                                       );
                                    //                                     },
                                    //                                   ),
                                    //                                   SizedBox(
                                    //                                     height: 30,
                                    //                                   )
                                    //                                 ],
                                    //                               ),
                                    //                             ),

                          ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: competition.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var competitionItem = competition.data![index];
                                return Card(
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
                                            SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: CustomImage(imgUrl: "${Constants.countryImage}${CountryShortName.country["${competitionItem.country.id}"]}.png",)
                                          ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(competitionItem.country.name,
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)
                                            ),
                                          ],
                                        ),
                                      ),
                                      children: [
                                        ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: competitionItem.leagues.length,
                                          itemBuilder: (widget, innerIndex) {
                                            var countryCompetition = competitionItem.leagues[innerIndex];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context, MaterialPageRoute(builder: (context) =>
                                                    LeagueHome(
                                                      leagueName: countryCompetition.league.name,
                                                      leagueId: countryCompetition.league.id,
                                                      logo: countryCompetition.league.logo,)));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: CustomImage(imgUrl:"${Constants.leagueImage}${countryCompetition.league.id}.png" ,)),
                                                    SizedBox(width: 10,),
                                                    Text(countryCompetition.league.name,
                                                        style: Theme.of(context).textTheme.bodyMedium
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
                                );
                              })
                        ],
                      ),
                      onFailure: (state)=> Center(child: Text("FAILD"),),
                    )
                  ],
                ),
              )
            ),
          ),
        ));
  }
}
