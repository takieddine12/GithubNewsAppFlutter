
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_flutter/models/news_model.dart';

import '../NewsData.dart';
class AuthService {

  Future<NewsData?> getEverything() async {
    var fullUrl = 'https://newsapi.org/v2/everything?q=LaLiga&apiKey=a9105f91876947b1b3b70761813fd4f9';
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
}