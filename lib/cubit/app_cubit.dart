import 'package:bloc/bloc.dart';
import 'package:news_app_flutter/cubit/app_cubit_state.dart';
import 'package:news_app_flutter/models/HeadlinesData.dart';



import '../models/Articles.dart';
import '../models/NewsData.dart';
import '../services/auth_service.dart';

class NewsCubit extends Cubit<NewsState> {

  NewsCubit({required this.authService}) : super(InitialState()){
      emit(SplashState());
  }
  late AuthService authService;
  NewsData? newsModel;
  HeadlinesData? headlinesData;

  getHeadlines() async {
    try {
      emit(LoadingState());
      headlinesData = await authService.getHeadlines();
      emit(HeadlinesState(headlinesData));
    }catch(e){
      //emit(LoadingState());
    }
  }

  getEverything(String query) async {
    try {
     // emit(LoadingState());
      newsModel = await authService.getEverything(query);
      emit(LoadedState(newsModel));
    }catch(e){

    }
  }


  getDetails(Articles articles){
    emit(NewsDetailsState(articles));
  }

  goHome(){
    emit(LoadedState(newsModel));
  }
}