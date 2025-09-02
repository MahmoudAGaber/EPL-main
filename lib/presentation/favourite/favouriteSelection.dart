
import 'package:epl/Data/StateModel.dart';
import 'package:epl/domain/models/Favorite.dart';
import 'package:epl/presentation/favourite/provider/favouriteViewModel.dart';
import 'package:epl/presentation/league/screens/homeLeague.dart';
import 'package:epl/presentation/team/screens/teamHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../shared/Utils/Constants.dart';
import '../../shared/Views/custom/custom_imageView.dart';
import '../../shared/Views/custom/custom_loader.dart';
import '../playrers/screens/playerHome.dart';


class FavouriteSelection extends ConsumerStatefulWidget {
  @override
  _FavouriteSelectionState createState() => _FavouriteSelectionState();
}

class _FavouriteSelectionState extends ConsumerState<FavouriteSelection> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(searchProvider.notifier).fetchDataSearch(" ");

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   var fav = ref.watch(favoriteProvider);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
            children: [
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         Icon(Icons.star,color: Colors.orange,size: 16,),
              //         SizedBox(width: 10,),
              //         Text("المفضلة",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14))
              //       ],
              //     ),
              //     SizedBox(height: 5,),
              //     Card(
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 12,bottom: 12),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: 65,
              //               width: MediaQuery.of(context).size.width*0.91,
              //               child: ListView.builder(
              //                   physics: BouncingScrollPhysics(),
              //                   shrinkWrap: true,
              //                   scrollDirection: Axis.horizontal,
              //                   itemCount: 5,
              //                   itemBuilder:(context,index){
              //                     return index ==0
              //                         ?Padding(
              //                       padding: const EdgeInsets.only(right: 18,left: 18),
              //                           child: Column(
              //                       children: [
              //                           Container(
              //                             height: 38,width: 38,
              //                             decoration: BoxDecoration(
              //                               borderRadius: BorderRadius.circular(50),
              //                               border: Border.all(
              //                                   color: Theme.of(context).primaryColor,
              //                                   width: 2
              //                               ),
              //                             ),
              //                             child:FittedBox(
              //                                   child: IconButton(
              //                                       onPressed: (){
              //                                        // searchViewModel.filterNewsSearch("1","favouritesList");
              //                                         searchIcon("",true,"favouritesList");
              //                                       },
              //                                       icon: Icon(Icons.add,color:Theme.of(context).colorScheme.error,)),
              //                                 )
              //                           ),
              //                           SizedBox(height: 5,),
              //                           Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium)
              //                       ],
              //                     ),
              //                         )
              //                         :Padding(
              //                       padding: const EdgeInsets.only(right: 18,left: 18),
              //                       child:Column(
              //                         children: [
              //                           Container(
              //                               height: 35,width: 35,
              //                               child:  ClipRRect(
              //                                     borderRadius: BorderRadius.circular(50),
              //                                     child: Image.network("https://www.eplworld.com"),
              //                                   )
              //                           ),
              //                           Text('text',style: Theme.of(context).textTheme.bodyMedium)
              //                         ],
              //                       ),
              //                     );
              //                   }),
              //             )
              //
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 12,),
              Column(
                children: [
                  Row(
                    children: [
                      Text("الفرق التي تتابعها",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12,bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          fav.handelState(
                              onLoading: (state) => CustomLoader(),
                              onSuccess: (state) => Container(
                                height: 95,
                                width: MediaQuery.of(context).size.width*0.91,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: fav.data!.length+1,
                                    itemBuilder:(context,index){
                                      return index ==0
                                          ?Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            Container(
                                                height: 38,width: 38,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Theme.of(context).primaryColor,
                                                      width: 2
                                                  ),
                                                ),
                                                child:FittedBox(
                                                    child: IconButton(
                                                        onPressed: (){
                                                          //searchViewModel.filterSearch("1","البطولات","leaguesList");
                                                          searchIcon("team",false,"leaguesList");
                                                        },
                                                        icon: Icon(Icons.add,color:Theme.of(context).iconTheme.color)
                                                    )
                                                )
                                            ),
                                            SizedBox(height: 5,),
                                            Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium!,textAlign: TextAlign.center,)
                                          ],
                                        ),
                                      )
                                          :fav.data![index-1].type == 'team'
                                          ?Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onLongPress: (){
                                                ref.read(favoriteProvider.notifier).toggleFavorite(fav.data![index-1]);
                                              },
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeTeam(
                                                              teamName:fav.data![index-1].name,
                                                              teamId: fav.data![index-1].id,
                                                              country: fav.data![index-1].country,
                                                            )));
                                              },
                                              child: Container(
                                                  height: 42,width: 42,
                                                  child:  ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(3.0),
                                                      child: CustomImage(imgUrl:"${Constants.teamImage}${fav.data![index-1].id}.png" ,),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                                child: Text(fav.data![index-1].name,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center))
                                          ],
                                        ),
                                      )
                                          :Container(height: 0,width: 0,color: Colors.orange,);
                                    },),
                              ),
                              onFailure: (state) => Text("SHIT")
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                children: [
                  Row(
                    children: [
                      Text("البطولات التي تتابعها",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14))
                    ],
                  ),
                  SizedBox(height: 5,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12,bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          fav.handelState(
                            onLoading: (state) => CustomLoader(),
                            onSuccess: (state) => Container(
                              height: 95,
                              width: MediaQuery.of(context).size.width*0.91,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: fav.data!.length+1,
                                  itemBuilder:(context,index){
                                    return index ==0
                                        ?Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 38,width: 38,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Theme.of(context).primaryColor,
                                                    width: 2
                                                ),
                                              ),
                                              child:FittedBox(
                                                  child: IconButton(
                                                      onPressed: (){
                                                        //searchViewModel.filterSearch("1","البطولات","leaguesList");
                                                        searchIcon("competition",false,"leaguesList");
                                                      },
                                                      icon: Icon(Icons.add,color:Theme.of(context).iconTheme.color)
                                                  )
                                              )
                                          ),
                                          SizedBox(height: 5,),
                                          Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium)
                                        ],
                                      ),
                                    )
                                        :fav.data![index-1].type == 'competition'
                                        ?Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                           GestureDetector(
                                            onLongPress: (){
                                              ref.read(favoriteProvider.notifier).toggleFavorite(fav.data![index-1]);
                                            },
                                             onTap: (){
                                               Navigator.push(
                                                   context, MaterialPageRoute(builder: (context) =>
                                                   LeagueHome(
                                                     leagueName: fav.data![index-1].name,
                                                     leagueId: fav.data![index-1].id,
                                                     logo: '',)));
                                             },
                                            child: Container(
                                                height: 35,width: 35,
                                                child:  ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: CustomImage(imgUrl:"${Constants.leagueImage}${fav.data![index-1].id}.png" ,),
                                                )
                                            ),
                                          ),
                                          SizedBox(
                                              width: 85,
                                              child: Text(fav.data![index-1].name,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,))
                                        ],
                                      ),
                                    ):SizedBox();
                                  }),
                            ),
                            onFailure: (state) => Text("SHIT")
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 12,),
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         Text("لاعبون تتابعهم",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14))
              //       ],
              //     ),
              //     SizedBox(height: 5,),
              //     Card(
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 12,bottom: 12),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: 65,
              //               width: MediaQuery.of(context).size.width*0.91,
              //               child: ListView.builder(
              //                   physics: BouncingScrollPhysics(),
              //                   shrinkWrap: true,
              //                   scrollDirection: Axis.horizontal,
              //                   itemCount: 5,
              //                   itemBuilder:(context,index){
              //                     return index ==0
              //                         ?Padding(
              //                       padding: const EdgeInsets.only(right: 18,left: 18),
              //                       child: Column(
              //                         children: [
              //                           Container(
              //                             height: 38,width: 40,
              //                             decoration: BoxDecoration(
              //                               borderRadius: BorderRadius.circular(50),
              //                               border: Border.all(
              //                                   color: Theme.of(context).primaryColor,
              //                                   width: 2
              //                               ),
              //                             ),
              //                             child:  FittedBox(
              //                                   child: IconButton(
              //                                       onPressed: (){
              //                                        // searchViewModel.filterSearch("1","اللاعبين","playersList");
              //                                         searchIcon("اللاعبين",false,"playersList");
              //                                       },
              //                                       icon: Icon(Icons.add,color:Theme.of(context).colorScheme.error)
              //                                   )
              //                             ),
              //                           ),
              //                           SizedBox(height: 5,),
              //                           Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium)
              //                         ],
              //                       ),
              //                     )
              //                         :Padding(
              //                       padding: const EdgeInsets.only(right: 18,left: 18),
              //                       child:Column(
              //                         children: [
              //                           Container(
              //                               height: 35,width: 35,
              //                               child:  ClipRRect(
              //                                 borderRadius: BorderRadius.circular(50),
              //                                 child: Image.network("https://www.eplworld.com"),
              //                               )
              //                           ),
              //                           Text("text",style: Theme.of(context).textTheme.bodyMedium)
              //                         ],
              //                       ),
              //                     );
              //                   }),
              //             )
              //
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          )

    );

  }


  searchIcon(String filter,bool favourite,String boxName) {
    //List<SearchResponseModel> searchItems=[];
    TextEditingController search = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Consumer(
                builder: (context, ref, child){
                  var dataSearch = ref.watch(searchProvider);
                  final favoriteState = ref.watch(favoriteProvider);

                  return Dialog(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      insetPadding:
                      EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: 10, left: 10),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                      Icons.arrow_forward,
                                      color: Theme.of(context).colorScheme.primaryContainer
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
                                    onChanged: (value) {
                                      ref.read(searchProvider.notifier).fetchDataSearch(value);
                                    },
                                    controller: search,
                                    textCapitalization:
                                    TextCapitalization.sentences,
                                    decoration: InputDecoration.collapsed(
                                        hintText:
                                        "إبحث"
                                            .tr,
                                        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 17)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dataSearch.handelState(
                              onLoading: (state) => CustomLoader(),
                              onSuccess: (state) =>  Expanded(
                                child: ListView.builder(
                                  itemCount: filter == 'team' ? dataSearch.data!.teams.length : dataSearch.data!.competitions.length,
                                  itemBuilder: (BuildContext context, index) {
                                    dynamic itemSearch = filter == 'team' ? dataSearch.data!.teams[index] : dataSearch.data!.competitions[index];

                                        final isFav = favoriteState.data?.any((fav) => fav.id == itemSearch.id) ?? false;

                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                            child: InkWell(
                                              onTap: () {
                                                String type = filter == 'team' ? 'team' : 'competition';
                                                FavoriteModel fav = FavoriteModel(id: itemSearch.id, name: itemSearch.name, type: type);
                                                ref.read(favoriteProvider.notifier).toggleFavorite(fav);
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 35,
                                                          width: 35,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(50),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: CustomImage(
                                                                imgUrl: "${filter == 'team' ? Constants.teamImage : Constants.leagueImage}${itemSearch.id}.png",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.65,
                                                          child: Text(
                                                            itemSearch.name,
                                                            style: Theme.of(context).textTheme.bodyMedium,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      String type = filter == 'team' ? 'team' : 'competition';
                                                      FavoriteModel fav = FavoriteModel(id: itemSearch.id, name: itemSearch.name, type: type);
                                                      ref.read(favoriteProvider.notifier).toggleFavorite(fav);
                                                    },
                                                    icon: Icon(
                                                      isFav ? Icons.star : Icons.star_border_outlined,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );

                                  },
                                )

                              ),
                              onFailure: (state) => Text("لا يوجد نتائج بحث")
                          )

                        ],
                      )

                  );
                },
              );
            },
          );
        });
  }

  selectedCategory( provider, index, search, searchItems) {
    var data = provider.searchItems[index];
    if (data.category == 'البطولات') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LeagueHome(
                leagueName: data.url,
              )));
    }
    if (data.category == 'الفرق') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeTeam(
                teamId: data.url,
              )));
    }
    if (data.category == 'اللاعبين') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Players(
              )));
    }
  }


}
