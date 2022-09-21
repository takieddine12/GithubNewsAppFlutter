import 'package:equatable/equatable.dart';
import '../models/Articles.dart';
import '../models/HeadlinesData.dart';
import '../models/NewsData.dart';


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

class HeadlinesState extends NewsState {
  HeadlinesData? headlineData;
  HeadlinesState(this.headlineData);
  @override
  // TODO: implement props
  List<Object?> get props => [headlineData];
}

class NewsDetailsState extends NewsState {
  Articles articles;
  NewsDetailsState(this.articles);
  @override
  // TODO: implement props
  List<Object?> get props => [articles];
}
