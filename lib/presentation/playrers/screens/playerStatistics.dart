import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/PlayerViewModel.dart';


class playerCareer extends ConsumerStatefulWidget {
  String? url;
  playerCareer({this.url});
  @override
  _playerStatisticsState createState() => _playerStatisticsState();
}

const TextStyle _textStyle = TextStyle(
    fontFamily: 'Vazirmatn',
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.w500);

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
                                                 child: Image.network(
                                                   "https://www.eplworld.com",fit: BoxFit.contain,),
                                               ),
                                             ),
                                             SizedBox(width: 12,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text("ssss",style: Theme.of(context).textTheme.bodyMedium),
                                                 Text("ssss",style: Theme.of(context).textTheme.bodySmall),
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
                           child: Text("dds",
                               style: Theme.of(context).textTheme.bodyMedium
                           ),
                         ),
                         Divider(),
                         Column(

                           children: [
                             ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                 itemCount: 5,
                                 itemBuilder: (context, index) {
                                   return Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(16),
                                         child: Row(
                                           children: [
                                             Container(
                                               width: 40,
                                               height: 40,
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.all(
                                                   Radius.circular(50),
                                                 ),
                                                 child: Image.network(
                                                   "https://www.eplworld.com",fit: BoxFit.contain,),
                                               ),
                                             ),
                                             SizedBox(width: 12,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text("s",style: Theme.of(context).textTheme.bodyMedium),
                                                 Text("ss",style: Theme.of(context).textTheme.bodySmall),
                                               ],
                                             )
                                           ],
                                         ),
                                       ),

                                       Divider()
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
