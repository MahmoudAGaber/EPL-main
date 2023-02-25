
import 'package:arseli/Provider/favouriteViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../EachLeague/eachLeague.dart';
import '../EachTeam/eachTeam.dart';
import '../Models/SearchModel.dart';
import '../Playrers/players.dart';
import '../Provider/EachLeagueViewModel.dart';
import '../Provider/EachPlayerViewModel.dart';
import '../Provider/EachTeamViewModel.dart';
import '../Provider/SearchViewModel.dart';


class FavouriteSelection extends StatefulWidget {
  @override
  _FavouriteSelectionState createState() => _FavouriteSelectionState();
}

class _FavouriteSelectionState extends State<FavouriteSelection> {

  SearchViewModel searchViewModel;
  FavouriteViewModel favouriteViewModel;
  List<SearchResponseModel> searchItemsClear =[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchViewModel = Provider.of(context, listen: false);
      favouriteViewModel = Provider.of(context, listen: false);
      //searchViewModel.getDataSearch('1');
      favouriteViewModel.getAllFavouriteItems("favouritesList");
      favouriteViewModel.getTeamsItems("teamsList");
      favouriteViewModel.getAllLeaguesItems("leaguesList");
      favouriteViewModel.getAllPlayersItems("playersList");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Consumer<FavouriteViewModel>(
        builder: (context,provider,child){
          return  Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.orange,size: 16,),
                      SizedBox(width: 10,),
                      Text("المفضلة",style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14))
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
                          Container(
                            height: 65,
                            width: MediaQuery.of(context).size.width*0.91,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.favouriteModelList == null ?1 :provider.favouriteModelList.length +1,
                                itemBuilder:(context,index){
                                  return index ==0
                                      ?Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                        child: Column(
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
                                                     // searchViewModel.filterNewsSearch("1","favouritesList");
                                                      searchIcon("",true,"favouritesList");
                                                    },
                                                    icon: Icon(Icons.add,color:Theme.of(context).colorScheme.error,)),
                                              )
                                        ),
                                        SizedBox(height: 5,),
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyText1)
                                    ],
                                  ),
                                      )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child: provider.favouriteModelList[index - 1].image.endsWith('svg')
                                                ? SvgPicture.network(
                                                "https://www.eplworld.com${provider.favouriteModelList[index - 1].image}",
                                                semanticsLabel:
                                                'Acme Logo')
                                                : ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(provider.favouriteModelList[index - 1].image.endsWith('small')
                                                  ? "${provider.favouriteModelList[index - 1].image.split('?').first}.jpg"
                                                  : "https://www.eplworld.com${provider.favouriteModelList[index - 1].image}"),
                                                )
                                        ),
                                        Text(provider.favouriteModelList[index - 1].text,style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                  );
                                }),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Column(
                children: [
                  Row(
                    children: [
                      Text("الفرق التي تتابعها",style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)),
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
                          Container(
                            height: 65,
                            width: MediaQuery.of(context).size.width*0.91,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.teamsModelList == null ?1 :provider.teamsModelList.length +1,
                                itemBuilder:(context,index){
                                  return index ==0
                                      ?Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child: Column(
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
                                                      //searchViewModel.filterSearch("1","الفرق","teamsList");
                                                      searchIcon("الفرق",false,"teamsList");
                                                    },
                                                    icon: Icon(Icons.add,color:Theme.of(context).colorScheme.error)),

                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child: provider.teamsModelList[index - 1].image.endsWith('svg')
                                                ? SvgPicture.network(
                                                "https://www.eplworld.com${provider.teamsModelList[index - 1].image}",
                                                semanticsLabel:
                                                'Acme Logo')
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network(provider.teamsModelList[index - 1].image.endsWith('small')
                                                  ? "${provider.teamsModelList[index - 1].image.split('?').first}.jpg"
                                                  : "https://www.eplworld.com${provider.teamsModelList[index - 1].image}"),
                                            )
                                        ),
                                        Text(provider.teamsModelList[index - 1].text,style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                  );
                                }),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Column(
                children: [
                  Row(
                    children: [
                      Text("البطولات التي تتابعها",style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14))
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


                          Container(
                            height: 65,
                            width: MediaQuery.of(context).size.width*0.91,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.leaguesiteModelList == null ?1 :provider.leaguesiteModelList.length +1,
                                itemBuilder:(context,index){
                                  return index ==0
                                      ?Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child: Column(
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
                                                      searchIcon("البطولات",false,"leaguesList");
                                                    },
                                                    icon: Icon(Icons.add,color:Theme.of(context).colorScheme.error)
                                                )
                                          )
                                        ),
                                        SizedBox(height: 5,),
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child: provider.leaguesiteModelList[index - 1].image.endsWith('svg')
                                                ? SvgPicture.network(
                                                "https://www.eplworld.com${provider.leaguesiteModelList[index - 1].image}",
                                                semanticsLabel:
                                                'Acme Logo')
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network(provider.leaguesiteModelList[index - 1].image.endsWith('small')
                                                  ? "${provider.leaguesiteModelList[index - 1].image.split('?').first}.jpg"
                                                  : "https://www.eplworld.com${provider.leaguesiteModelList[index - 1].image}"),
                                            )
                                        ),
                                        Text(provider.leaguesiteModelList[index - 1].text,style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                  );
                                }),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Column(
                children: [
                  Row(
                    children: [
                      Text("لاعبون تتابعهم",style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14))
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
                          Container(
                            height: 65,
                            width: MediaQuery.of(context).size.width*0.91,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.playerModelList == null ?1 :provider.playerModelList.length +1,
                                itemBuilder:(context,index){
                                  return index ==0
                                      ?Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 38,width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(
                                                color: Theme.of(context).primaryColor,
                                                width: 2
                                            ),
                                          ),
                                          child:  FittedBox(
                                                child: IconButton(
                                                    onPressed: (){
                                                     // searchViewModel.filterSearch("1","اللاعبين","playersList");
                                                      searchIcon("اللاعبين",false,"playersList");
                                                    },
                                                    icon: Icon(Icons.add,color:Theme.of(context).colorScheme.error)
                                                )
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child: provider.playerModelList[index - 1].image.endsWith('svg')
                                                ? SvgPicture.network(
                                                "https://www.eplworld.com${provider.playerModelList[index - 1].image}",
                                                semanticsLabel:
                                                'Acme Logo')
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network(provider.playerModelList[index - 1].image.endsWith('small')
                                                  ? "${provider.playerModelList[index - 1].image.split('?').first}.jpg"
                                                  : "https://www.eplworld.com${provider.playerModelList[index - 1].image}"),
                                            )
                                        ),
                                        Text(provider.playerModelList[index - 1].text,style: Theme.of(context).textTheme.bodyText1)
                                      ],
                                    ),
                                  );
                                }),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
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
              return Dialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                insetPadding:
                EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Consumer<SearchViewModel>(
                  builder: (context, provider, child) {
                    var data = provider.searchItems;
                    return data.isEmpty
                        ?Container()
                        :Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, right: 10, left: 10),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                    Icons.arrow_forward,
                                    color: Theme.of(context).colorScheme.primaryVariant
                                ),
                                onPressed: () {
                                  provider.filterSearch('1',filter,boxName);
                                  Navigator.pop(context);
                                  setState(() {
                                    searchViewModel.searchItems.clear();
                                    searchViewModel.searchItems = searchItemsClear;
                                    data.clear();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    data.where((element) => element.text.toLowerCase().contains(value)).toList();
                                    provider.filterSearch(value,filter,boxName);
                                  },
                                  controller: search,
                                  textCapitalization:
                                  TextCapitalization.sentences,
                                  decoration: InputDecoration.collapsed(
                                      hintText:
                                      "إبحث"
                                          .tr,
                                      hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 17)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: search.text.isNotEmpty
                                  ? provider.searchItems.length
                                  :provider.searchItems.length,
                              itemBuilder: (BuildContext context, index) {
                                var itemData = data[index];
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10,top: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedCategory(provider, index, search, provider.searchItems);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                    height: 30,
                                                    width: 30,
                                                    child: search.text.isNotEmpty
                                                        ? (itemData.image.endsWith('svg')
                                                        ? SvgPicture.network(
                                                        "https://www.eplworld.com${itemData.image}",
                                                        semanticsLabel:
                                                        'Acme Logo')
                                                        : Image.network(itemData.image.endsWith('small')
                                                        ? "${itemData.image.split('?').first}.jpg"
                                                        : "https://www.eplworld.com${itemData.image}"))
                                                        : (itemData.image
                                                        .endsWith('svg')
                                                        ? SvgPicture.network(
                                                        "https://www.eplworld.com${itemData.image}",
                                                        semanticsLabel:
                                                        'Acme Logo')
                                                        : ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                          child: Image.network(itemData.image.endsWith('small')
                                                          ? "${itemData.image.split('?').first}.jpg"
                                                          : "https://www.eplworld.com${itemData.image}"),
                                                        ))),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.65,
                                                  child: Text(
                                                    search.text.isNotEmpty
                                                        ? itemData
                                                        .text
                                                        : itemData
                                                        .text,
                                                    style: Theme.of(context).textTheme.bodyText1,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Selector<FavouriteViewModel,bool>(
                                            selector: (contex,provider) =>
                                            provider.getFavouriteLoading,
                                            builder: (context,loading,child){
                                              return IconButton(
                                                  onPressed:(){
                                                    setState((){
                                                      if(provider.searchItems[index].isFavourite == false){
                                                        provider.searchItems[index].isFavourite = true;
                                                        favouriteViewModel.addFavouriteItem(provider.searchItems[index],boxName);
                                                      }else if (provider.searchItems[index].isFavourite == true){
                                                        provider.searchItems[index].isFavourite = false;
                                                        favouriteViewModel.removeFavouriteItem(provider.searchItems[index],boxName);
                                                      }

                                                    });

                                                  },
                                                  icon:Icon(
                                                    provider.searchItems[index].isFavourite==true
                                                        ?Icons.star
                                                        :Icons.star_border,
                                                    color: Colors.orange,size: 20,));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
        }).then((value) {
      searchViewModel.filterSearch('1',filter,boxName);
      setState(() {
        searchViewModel.searchItems.clear();
        searchViewModel.searchItems = searchItemsClear;
      });

    });
  }

  selectedCategory(SearchViewModel provider, index, search, searchItems) {
    var data = provider.searchItems[index];
    if (data.category == 'البطولات') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<EachLeagueViewModel>(
                  create: (_) => EachLeagueViewModel(),
                  child: search.text.isNotEmpty
                      ? EachLeague(
                    url: searchItems[index].url,
                  )
                      : EachLeague(
                    url: data.url,
                  ))));
    }
    if (data.category == 'الفرق') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<EachTeamViewModel>(
                  create: (_) => EachTeamViewModel(),
                  child: search.text.isNotEmpty
                      ? EachTeam(
                    url: searchItems[index].url,
                  )
                      : EachTeam(
                    url: data.url,
                  ))));
    }
    if (data.category == 'اللاعبين') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<EachplayerViewModel>(
                  create: (_) => EachplayerViewModel(),
                  child: search.text.isNotEmpty
                      ? EachPlayer(
                    url: searchItems[index].url,
                  )
                      : EachPlayer(
                    url: data.url,
                  ))));
    }
  }


}
