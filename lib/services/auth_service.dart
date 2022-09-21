import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/HeadlinesData.dart';
import '../models/NewsData.dart';
class AuthService {

  Future<NewsData?> getEverything(String query) async {
    var fullUrl = 'https://newsapi.org/v2/everything?q=${query}&apiKey=a9105f91876947b1b3b70761813fd4f9';
    try{
      var httpRequest  = await http.get(Uri.parse(fullUrl));
      if(httpRequest.statusCode == 200){
        var response = jsonDecode(httpRequest.body);
        return NewsData.fromJson(response);
      } else {
        return null;
      }
    } catch(e){
      return null;
    }
  }
  Future<HeadlinesData?> getHeadlines() async {
    var fullUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=a9105f91876947b1b3b70761813fd4f9';
    try {
      var response  = await http.get(Uri.parse(fullUrl));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        return HeadlinesData.fromJson(data);
      } else {
        return null;
      }
    } catch(e){
        return null;
    }
  }
}