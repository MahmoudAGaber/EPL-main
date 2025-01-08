

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';
import '../../../domain/models/Player.dart';




final PlayerProvider = StateNotifierProvider<PlayerNotifier,StateModel<PlayerModel>>((ref) => PlayerNotifier(ref));


class PlayerNotifier extends StateNotifier<StateModel<PlayerModel>>{
  Ref ref;
  PlayerNotifier(this.ref):super(StateModel.loading());

  Future<void> getPlayer(playerId) async{
    RequestHandler requestHandler = RequestHandler();
    PlayerModel playerModel;
    Map<String, dynamic> body;
   try {

      body = {
        "lang": "ar",
        "player_id": playerId
      };

      state = StateModel.loading();
      playerModel = await requestHandler.postData(
        endPoint: "soccer/player/career",
        auth: true,
        requestBody: body,
        fromJson: (json)=> PlayerModel.fromJson(json),
      );


      state = StateModel.success(playerModel);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}