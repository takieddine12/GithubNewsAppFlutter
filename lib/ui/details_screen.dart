import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/cubit/app_cubit.dart';
import 'package:news_app_flutter/cubit/app_cubit_state.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({Key? key}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsCubit,NewsState>(
        builder: (context , state){
           NewsDetailsState newsDetailsState = state as NewsDetailsState;
           var article = newsDetailsState.articles;
           return Stack(
             fit: StackFit.expand,
             children: [
               Positioned(
                 child: Container(
                   height: 350,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image: NetworkImage(article.urlToImage!),
                           fit: BoxFit.cover
                       )
                   ),
                 ),
               ),
               Positioned(
                 top: 70,
                 left: 20,
                 child: GestureDetector(
                   onTap: (){
                     BlocProvider.of<NewsCubit>(context).goHome();
                   },
                   child: Container(
                     padding: const EdgeInsets.all(6),
                     decoration: BoxDecoration(
                       color: Colors.black12,
                       borderRadius: BorderRadius.circular(6)
                     ),
                     child: const Center(child: Icon(Icons.arrow_back,color: Colors.white,)),
                   ),
                 ),
               ),
               Positioned(
                 top: 320,
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   height: 550,
                   decoration: const BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                   ),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                     child: Text(article.description!,style: TextStyle(
                       fontFamily: 'nunito_bold',
                       fontSize: 18,
                     ),),
                   ),
                 ),
               )
             ],
           );
        },
      ),
    );
  }
}
