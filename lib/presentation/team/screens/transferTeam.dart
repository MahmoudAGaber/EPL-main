import 'package:epl/Data/StateModel.dart';
import 'package:epl/domain/usecases/TeamUseCases.dart';
import 'package:epl/presentation/team/provider/TeamViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/Utils/Constants.dart';
import '../../../shared/Utils/date_converter.dart';
import '../../../shared/Views/custom/custom_imageView.dart';
import '../../../shared/Views/custom/custom_loader.dart';
import '../../../shared/helper/countryShortName.dart';
import '../../playrers/screens/playerHome.dart';
import 'teamHome.dart';

class tranferTeam extends ConsumerStatefulWidget {
  String? url;
  tranferTeam({this.url});
  @override
  _tranferTeamState createState() => _tranferTeamState();
}

class _tranferTeamState extends ConsumerState<tranferTeam> {
  NormalizePositionUseCase normalizePositionUseCase = NormalizePositionUseCase();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var transfers = ref.watch(teamTransferProvider);

    return transfers.handelState(
        onLoading: (state)=> CustomLoader(),
        onSuccess: (state)=>  Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: transfers.data!.length <= 50 ? transfers.data!.length : 50,
              itemBuilder: (BuildContext context, index) {
                var player = transfers.data![index];
                return Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Players(
                                                        playerId: player.personId,
                                                      )));
                                            },
                                            child: Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(50)),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(50)),
                                                  child: CustomImage(imgUrl:"${Constants.countryImage}${CountryShortName.country["${player.personId}"]}.png" ,)),
                                            )
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10,),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: Theme.of(context).primaryColor
                                              ),

                                            child:Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Text(normalizePositionUseCase.shortPosition(player.position),style: TextStyle(color: Colors.white,fontSize: 10),),
                                            )


                                            ),
                                            SizedBox(width: 5,),
                                            Text(player.name,
                                                style: Theme.of(context).textTheme.bodyMedium
                                            ),
                                          ],
                                        ),

                                    SizedBox(height: 2,),
                                    Row(
                                      children: [
                                        Text('الجنسيه',style: TextStyle(color: Colors.black54),),
                                        SizedBox(width: 5,),
                                        ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(25)),
                                            child: CustomImage(imgUrl:"${Constants.countryImage}${CountryShortName.country["${player.nationalityId}"]}.png",height: 20,width: 20,))
                                      ],
                                    ),

                                      ],
                                    ),
                                  ],
                                ),

                                Expanded(
                                    child: Text(transfers.data![index].membership.first.startDate,
                                      style:Theme.of(context).textTheme.bodyMedium,
                                      textAlign: TextAlign.left,))

                              ],
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: Text(player.membership.first.transfer.fromClubName,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style:Theme.of(context).textTheme.bodyMedium,
                                          )
                                      ),
                                      SizedBox(width: 5,),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeTeam(
                                                        teamId:player.membership.first.transfer.fromTeamId,teamName: player.membership.first.transfer.fromClubName)));
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          child: CustomImage(imgUrl: "${Constants.teamImage}${player.membership.first.transfer.fromTeamId}.png",),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15,right: 15),
                                        child: Container(
                                            width: 40,
                                            height: 16,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF42c713),
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        100))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Container(
                                                  height: 10,width: 25,
                                                  child: RotatedBox(
                                                      quarterTurns: 2,
                                                      child: Image.asset('assets/arrow.png',fit: BoxFit.contain,))),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeTeam(
                                                          teamId: player.membership.first.teamId,teamName: player.membership.first.clubName,)));
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          child: CustomImage(imgUrl: "${Constants.teamImage}${player.membership.first.teamId}.png",),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.21,
                                        child: Text(player.membership.first.clubName,
                                          textDirection: TextDirection.rtl,
                                          style:Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            player.membership.first.transfer.value.isNotEmpty ?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(player.membership.first.transfer.currency ?? "",
                                    style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.green,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 8,),

                                  Text(DateConverter.numberFormat(double.tryParse(player.membership.first.transfer.value)),
                                    style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.green,fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ):SizedBox(),
                            // Divider(),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(player.membership.first.endDate,
                            //     style:Theme.of(context).textTheme.bodyMedium,),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        onFailure: (state)=> Text("Shit")
    );

  }
  
}
