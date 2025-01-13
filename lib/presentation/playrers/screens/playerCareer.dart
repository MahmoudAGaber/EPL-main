import 'package:epl/shared/Views/custom/custom_imageView.dart';
import 'package:epl/shared/helper/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/Utils/Constants.dart';
import '../provider/PlayerViewModel.dart';


class playerCareer extends ConsumerStatefulWidget {
  String? url;
  playerCareer({this.url});
  @override
  _playerStatisticsState createState() => _playerStatisticsState();
}


class _playerStatisticsState extends ConsumerState<playerCareer> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    }); //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var player = ref.watch(PlayerProvider);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width,
                   child: Card(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(padding: const EdgeInsets.all(12.0),
                           child: Text('النادي الحالي',
                             style: Theme.of(context).textTheme.bodyMedium
                           ),
                         ),
                         Divider(),
                         Column(
                           children: [
                             ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                 itemCount: 1,
                                 itemBuilder: (context, index) {
                                   var team = player.data!.teamCareer.club[index];
                                   if(team.active == 'yes')
                                     return Column(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.all(12),
                                           child: Row(
                                             children: [
                                               Container(
                                                 width: 40,
                                                 height: 40,
                                                 child: ClipRRect(
                                                     borderRadius: BorderRadius.all(
                                                       Radius.circular(50),
                                                     ),
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(4.0),
                                                       child: CustomImage(imgUrl: "${Constants.teamImage}${team.teamId}.png",),
                                                     )
                                                 ),
                                               ),
                                               SizedBox(width: 12,),
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text(team.clubName,style: Theme.of(context).textTheme.bodyMedium),
                                                   Text(DateConverter.isoStringToYM(team.startDate),style: Theme.of(context).textTheme.bodySmall),
                                                 ],
                                               )
                                             ],
                                           ),
                                         ),
                                       ],

                                     );
                                 })
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
                 SizedBox(height: 8,),
                 Container(
                   width: MediaQuery
                       .of(context)
                       .size
                       .width,
                   child: Card(
                     shape: RoundedRectangleBorder(
                         borderRadius:
                         BorderRadius.all(Radius.circular(10.0))),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Text("المهنة",
                               style: Theme.of(context).textTheme.bodyMedium
                           ),
                         ),
                         Divider(),
                         Column(

                           children: [
                             ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                 itemCount: player.data!.teamCareer.club.length,
                                 itemBuilder: (context, index) {
                                   var club = player.data!.teamCareer.club[index];
                                   return Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(12),
                                         child: Row(
                                           children: [
                                             Container(
                                               width: 40,
                                               height: 40,
                                               child: ClipRRect(
                                                   borderRadius: BorderRadius.all(
                                                     Radius.circular(50),
                                                   ),
                                                   child: Padding(
                                                     padding: const EdgeInsets.all(4.0),
                                                     child: CustomImage(imgUrl: "${Constants.teamImage}${club.teamId}.png",),
                                                   )
                                               ),
                                             ),
                                             SizedBox(width: 12,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(club.clubName,style: Theme.of(context).textTheme.bodyMedium),
                                                 Text(DateConverter.isoStringToYM(club.startDate),style: Theme.of(context).textTheme.bodySmall),
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     ],

                                   );
                                 })
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ],
             ),
         ],

             ),
           );
  }
}
