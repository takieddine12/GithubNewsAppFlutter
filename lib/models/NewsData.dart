import 'Articles.dart';

class NewsData {
  NewsData({
      String? status, 
      num? totalResults, 
      List<Articles>? articles,}){
    _status = status;
    _totalResults = totalResults;
    _articles = articles;
}

  NewsData.fromJson(dynamic json) {
    _status = json['status'];
    _totalResults = json['totalResults'];
    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles?.add(Articles.fromJson(v));
      });
    }
  }
  String? _status;
  num? _totalResults;
  List<Articles>? _articles;
NewsData copyWith({  String? status,
  num? totalResults,
  List<Articles>? articles,
}) => NewsData(  status: status ?? _status,
  totalResults: totalResults ?? _totalResults,
  articles: articles ?? _articles,
);
  String? get status => _status;
  num? get totalResults => _totalResults;
  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['totalResults'] = _totalResults;
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



