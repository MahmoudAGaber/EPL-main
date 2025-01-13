
import 'package:epl/presentation/league/screens/homeLeague.dart';
import 'package:epl/presentation/team/screens/teamHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../playrers/screens/playerHome.dart';


class FavouriteSelection extends StatefulWidget {
  @override
  _FavouriteSelectionState createState() => _FavouriteSelectionState();
}

class _FavouriteSelectionState extends State<FavouriteSelection> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Consumer(
        builder: (context,provider,child){
          return  Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.orange,size: 16,),
                      SizedBox(width: 10,),
                      Text("المفضلة",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14))
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
                                itemCount: 5,
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
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium)
                                    ],
                                  ),
                                      )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child:  ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network("https://www.eplworld.com"),
                                                )
                                        ),
                                        Text('text',style: Theme.of(context).textTheme.bodyMedium)
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
                          Container(
                            height: 65,
                            width: MediaQuery.of(context).size.width*0.91,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
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
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium)
                                      ],
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network("https://www.eplworld.com"),
                                            )
                                        ),
                                        Text('text',style: Theme.of(context).textTheme.bodyMedium)
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
                      Text("البطولات التي تتابعها",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14))
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
                                itemCount: 5,
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
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium)
                                      ],
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child:  ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network("https://www.eplworld.com"),
                                            )
                                        ),
                                        Text("text",style: Theme.of(context).textTheme.bodyMedium)
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
                      Text("لاعبون تتابعهم",style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14))
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
                                itemCount: 5,
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
                                        Text("أضف لاختيارك",style: Theme.of(context).textTheme.bodyMedium)
                                      ],
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.only(right: 18,left: 18),
                                    child:Column(
                                      children: [
                                        Container(
                                            height: 35,width: 35,
                                            child:  ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network("https://www.eplworld.com"),
                                            )
                                        ),
                                        Text("text",style: Theme.of(context).textTheme.bodyMedium)
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
                child: Consumer(
                  builder: (context, provider, child) {
                    return Column(
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
                                onPressed: () {},
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
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
                        Expanded(
                          child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10,top: 10),
                                    child: GestureDetector(
                                      onTap: () {
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
                                                    child:  ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                          child: Image.network( "https://www.eplworld.com"))),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.65,
                                                  child: Text("text",
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed:(){},
                                              icon:Icon(Icons.star, color: Colors.orange,size: 20,))
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
