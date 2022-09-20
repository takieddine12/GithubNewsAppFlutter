import 'package:bloc/bloc.dart';
import 'package:news_app_flutter/cubit/app_cubit_state.dart';
import 'package:news_app_flutter/models/news_model.dart';

import '../NewsData.dart';
import '../services/auth_service.dart';

class NewsCubit extends Cubit<NewsState> {

  NewsCubit({required this.authService}) : super(InitialState()){
      emit(SplashState());
  }
  late AuthService authService;
  NewsData? newsModel;

  getEverything() async {
    try {
      emit(LoadingState());
      newsModel = await authService.getEverything();
      print("newsdata $newsModel");
      emit(LoadedState(newsModel));
    }catch(e){

    }
  }

}