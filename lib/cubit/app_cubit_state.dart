

import 'package:equatable/equatable.dart';
import 'package:news_app_flutter/models/news_model.dart';

import '../NewsData.dart';

class NewsState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class InitialState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SplashState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadingState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedState extends NewsState {
  NewsData? newsModel;
  LoadedState(this.newsModel);
  @override
  // TODO: implement props
  List<Object?> get props => [newsModel];
}

