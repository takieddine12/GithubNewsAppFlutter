
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/cubit/app_cubit.dart';
import 'package:news_app_flutter/cubit/app_cubit_state.dart';
import 'package:news_app_flutter/models/news_model.dart';
import 'package:news_app_flutter/ui/home_screen.dart';
import 'package:news_app_flutter/ui/splash_screen.dart';

class AppCubitLogic extends StatefulWidget {
  const AppCubitLogic({Key? key}) : super(key: key);

  @override
  State<AppCubitLogic> createState() => _AppCubitLogicState();
}

class _AppCubitLogicState extends State<AppCubitLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsCubit,NewsState>(
        builder: (context , state){
          if(state is LoadingState){
            return const Center(
              child: CircularProgressIndicator(color: Colors.black54,),
            );
          }
          else if (state is SplashState){
             return const SplashScreen();
          } else if (state is LoadedState){
             return const HomeScreen();
          } else {
             return Container();
          }
        },
      ),
    );
  }
}
