import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/cubit/app_cubit.dart';
import 'package:news_app_flutter/services/auth_service.dart';
import 'package:news_app_flutter/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 7),(){
      BlocProvider.of<NewsCubit>(context).getEverything('sport');
      //BlocProvider.of<NewsCubit>(context).getHeadlines();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/gifs/news.gif',),
      ),
    );
  }
}
