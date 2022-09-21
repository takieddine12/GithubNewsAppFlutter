import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    return WillPopScope(
        child: Scaffold(
          body: BlocBuilder<NewsCubit,NewsState>(
            builder: (context , state){
              NewsDetailsState newsDetailsState = state as NewsDetailsState;
              var article = newsDetailsState.articles;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Stack(
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
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                            child: Text(article.description!,style: const TextStyle(
                              fontFamily: 'nunito_bold',
                              fontSize: 18,
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 210,
                    left: 40,
                    right: 40,
                    child:  Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(formatDate(article.publishedAt!),style: const TextStyle(color: Colors.white,
                            fontFamily: 'nunito_semi'),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(article.title!,style: const TextStyle(color: Colors.white,
                            fontFamily: 'nunito_bold'),maxLines: 2,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(article.author == null ? 'Published By N/A' : 'Published By ${article.author!}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white,fontFamily: 'nunito_semi'),),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        onWillPop: () async {
           BlocProvider.of<NewsCubit>(context).goHome();
           return true;
        });
  }

  String formatDate(String date){
    DateFormat dt1 = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    DateTime dtime = dt1.parse(date);
    DateFormat dt2 = DateFormat('EEEE , MMM d, ''yyyy');
    return dt2.format(dtime);
  }
}
