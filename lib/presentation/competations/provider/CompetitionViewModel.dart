
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';
import '../../../domain/Models/Competition.dart';


final CompetitionProvider = StateNotifierProvider<CompetitionNotifier,StateModel<List<CompetitionModel>>>((ref) => CompetitionNotifier(ref));

final TopCompetitionProvider = StateNotifierProvider<TopCompetitionNotifier,StateModel<List<Leagues>>>((ref) => TopCompetitionNotifier(ref));



class CompetitionNotifier extends StateNotifier<StateModel<List<CompetitionModel>>>{
  Ref ref;
  CompetitionNotifier(this.ref):super(StateModel.loading());

  Future<void> getCompetition() async{
    RequestHandler requestHandler = RequestHandler();
    List<CompetitionModel> competitionModel;
    Map<String, dynamic> body;
    try {

      body = {
        "lang": "ar"
      };

      state = StateModel.loading();
      competitionModel = await requestHandler.postData(
        endPoint: "soccer/competition/all",
        auth: true,
        requestBody: body,
        fromJson: (json)=> CompetitionModel.listFromJson(json),
      );

      state = StateModel.success(competitionModel);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}

class TopCompetitionNotifier extends StateNotifier<StateModel<List<Leagues>>>{
  Ref ref;
  TopCompetitionNotifier(this.ref):super(StateModel.loading());

  Future<void> getTopCompetition() async{
    RequestHandler requestHandler = RequestHandler();
    List<Leagues> leagues;
    Map<String, dynamic> body;

      body = {
        "lang": "ar"
      };

      state = StateModel.loading();
      leagues = await requestHandler.postData(
        endPoint: "soccer/competition/top-10",
        auth: true,
        requestBody: body,
        fromJson: (json)=> Leagues.listFromJson(json),
      );

      state = StateModel.success(leagues);


  }
}

