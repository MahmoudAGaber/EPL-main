import 'package:epl/Data/StateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Views/custom/custom_loader.dart';
import '../../../shared/Views/custom/standingLabels.dart';
import '../../../shared/Views/custom/teamInStanding.dart';
import '../provider/TeamViewModel.dart';

class TeamPosition extends ConsumerStatefulWidget {
  String? url;
  String? teamId;
  TeamPosition({this.url, this.teamId});

  @override
  _TeamPositionState createState() => _TeamPositionState();
}

var indexx = 2;

class _TeamPositionState extends ConsumerState<TeamPosition> {
  TextStyle tapbar = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13,
  );
  TextStyle headline = TextStyle(
      fontFamily: 'Vazirmatn', fontSize: 11, fontWeight: FontWeight.w600);
  TextStyle titleMedium =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, color: Colors.grey);
  TextStyle content = TextStyle(
    fontFamily: 'Vazirmatn',
    fontSize: 13.5,
  );

  List? dropList;
  String? selectedItem;
  String? seasonId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var teamSeaons = ref.watch(TeamSeasonsProvider);
    var table = ref.watch(TeamTableProvider);
    var standingType = ref.watch(StandingTypeProvider);

    if(table.data !=null){
      seasonId = table.data!.seasonId;
    }

    return SingleChildScrollView(
      child: teamSeaons.handelState(
        onLoading: (state)=> CustomLoader(),
        onFailure: (state)=> Text("Shit"),
        onSuccess: (state)=> Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Card(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
          ),
          // Ensure the value matches exactly one item in the dropdown
          value: selectedItem ?? teamSeaons.data!.first.name,
          isExpanded: true,
          menuMaxHeight: 300,
          items: teamSeaons.data!.map((e) => e.name).toSet().map((name) => DropdownMenuItem<String>(
            value: name,
            onTap: () {
              final season = teamSeaons.data!.firstWhere((e) => e.name == name);
              seasonId = season.seasonId;
              ref.read(TeamTableProvider.notifier).getTable(season.seasonId,'total');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedItem = value;
            });
          },
        ),
      ),
              SizedBox(
                height: 8,
              ),
              table.handelState(
                onLoading: (state)=> CustomLoader(),
                onSuccess: (state)=> Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      InkWell(
                        onTap:(){
                          ref.read(TeamTableProvider.notifier).getTable(seasonId!,'total');
                          ref.read(StandingTypeProvider.notifier).state = StandingType.All;
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: standingType == StandingType.All ? Theme.of(context).primaryColor :Colors.white
                          ),
                          child: Center(child: Text('الكل',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: standingType == StandingType.All? Colors.white : null),)),
                        ),
                      ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: (){
                          ref.read(TeamTableProvider.notifier).getTable(seasonId!,'home');
                          ref.read(StandingTypeProvider.notifier).state = StandingType.Home;
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: standingType == StandingType.Home ? Theme.of(context).primaryColor :Colors.white
                          ),
                          child: Center(child: Text('ذهاب',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: standingType == StandingType.Home? Colors.white : null),)),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          ref.read(TeamTableProvider.notifier).getTable(seasonId!,'away');
                          ref.read(StandingTypeProvider.notifier).state = StandingType.Away;
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: standingType == StandingType.Away ? Theme.of(context).primaryColor :Colors.white
                          ),
                          child: Center(child: Text('اياب',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: standingType == StandingType.Away? Colors.white : null),)),
                        ),
                      ),
                      ],
                    ),
                    SizedBox(height: 8,),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(right: 16,left: 16,top: 12,bottom: 8),
                                  child: Row(
                                    children: [
                                      // CircleAvatar(radius: 10,),
                                      SizedBox(width: 5,),
                                      Text(table.data!.name,
                                          style: Theme.of(context).textTheme.titleMedium
                                      ),
                                    ],
                                  )
                              ),
                              Divider(),
                              StandingLabels()
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              itemCount: table.data!.standings[0].length,
                              itemBuilder: (BuildContext context, index) {
                                var team = table.data!.standings[0][index];

                                return TeamInStanding(team:team, teamId: widget.teamId!,);
                              }),


                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 10,
                                  bottom: 10,
                                  left: 10,
                                  top: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(4),
                                        color: Colors.yellow),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "texet",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                    !.copyWith(fontSize: 13.5),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
                onFailure: (state)=> Text("Shit")
              )
            ],
          ),
        ),

      )
    );
  }
}
