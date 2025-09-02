
import 'package:epl/presentation/favourite/provider/favouriteViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';
import '../../../domain/Models/Matches.dart';



final MatchesProvider = StateNotifierProvider<MatchesNotifier,StateModel<List<MatchesModel>>>((ref) => MatchesNotifier(ref));



class MatchesNotifier extends StateNotifier<StateModel<List<MatchesModel>>>{
  Ref ref;
  MatchesNotifier(this.ref):super(StateModel.loading());

  bool liveMatch = false;
  bool withTime = false;
  bool isFav = false;

  Future<void> getMatches(String matchDate,{bool liveMatch = false, bool withTime = false, bool isFav = false}) async{
    RequestHandler requestHandler = RequestHandler();
    List<MatchesModel> matches;
    var favState = ref.read(favoriteProvider);

    Map<String, dynamic> body;
    try {

      body = {
        "date": matchDate,
        "lang": "ar"
      };

      state = StateModel.loading();
      matches = await requestHandler.postData(
        endPoint: !this.liveMatch? "soccer/fixture/by-date" : "soccer/fixture/live",
        auth: true,
        requestBody: body,
        fromJson: (json)=> MatchesModel.listFromJson(json),
      );

      if(isFav){
        matches = matches.where((fixture)=> favState.data?.any((fav) => fav.id == fixture.league.id)?? false).toList();
      }

      if(this.withTime){
        matches.forEach((element) {element.items.sort((a,b)=> a.fixture.date.compareTo(b.fixture.date));});
      }
      if(matches.isNotEmpty){
        state = StateModel.success(matches);

      }else{
        state = StateModel.empty();
      }

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}


