import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/cubit/app_cubit.dart';
import 'package:news_app_flutter/cubit/app_cubit_state.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _searchKey = GlobalKey<FormState>();

  final _queries = [
    'Health',
    'Sport',
    'Politics',
    'Economy',
    'Education'
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
              child: Form(
                key: _searchKey,
                child: TextFormField(
                  controller: _searchController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please write something';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      hintText: 'search',
                      hintStyle: const TextStyle(fontStyle: FontStyle.italic,fontFamily: 'nunito_regular'),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black45),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      suffixIcon:  IconButton(
                        onPressed: (){
                          var isSearchEditValidated = _searchKey.currentState!.validate();
                          if(isSearchEditValidated){
                            context.read<NewsCubit>().getEverything(_searchController.text);
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        icon: const Icon(Icons.search,color: Colors.black54,size: 20,),)
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _queries.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF3A44),
                                Color(0xFFFF8086),
                              ],
                              stops: [1.0, 0.0],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              tileMode: TileMode.clamp
                          )
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(right: 20,left: 20),
                        child: GestureDetector(
                          onTap: (){
                            context.read<NewsCubit>().getEverything(_queries[index]);
                          },
                          child: Text(_queries[index],style: const TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,fontFamily: 'nunito_bold'),),
                        ),
                      )),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                child: SizedBox(
                  width: 350,
                  height: 150,
                  child :  BlocBuilder<NewsCubit,NewsState>(
                    builder: (context , state){
                      if(state is LoadingState){
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black87,),
                        );
                      }
                      else if(state is LoadedState){
                        var news = state.newsModel;
                        return ListView.builder(
                          cacheExtent: 9999,
                          itemCount: news!.articles!.length,
                          itemBuilder: (context , index){
                            return GestureDetector(
                              onTap: (){
                                BlocProvider.of<NewsCubit>(context).getDetails(news.articles![index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: news.articles![index].urlToImage == null ? Container() : Image.network(news.articles![index].urlToImage!,fit: BoxFit.cover,
                                      filterQuality: FilterQuality.low,),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 20,
                                      right : 20,
                                      child: SizedBox(
                                          width : 350,
                                          child: Text(news.articles![index].title!,style: const TextStyle(color: Colors.white,
                                              fontSize: 17,fontWeight: FontWeight.bold,fontFamily: 'nunito_bold'),maxLines: 2)),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 20,
                                      right : 20,
                                      child: Row(
                                        mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(news.articles![index].author == null ? 'by N/A' : 'by ${news.articles![index].author}',
                                              style: const TextStyle(color: Colors.white,fontFamily: 'nunito_semi'),),
                                          ),
                                          Text(formatDate(news.articles![index].publishedAt!),style: const TextStyle(color: Colors.white,
                                              fontFamily: 'nunito_semi'),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      else {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black87,),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String date){
    DateFormat dt1 = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    DateTime dtime = dt1.parse(date);
    DateFormat dt2 = DateFormat('yyyy-MM-dd HH:mm');
    return dt2.format(dtime);
  }
}
/*
  Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 350,
                height: 250,
                child :  BlocBuilder<NewsCubit,NewsState>(
                  builder: (context , state){
                    if(state is HeadlinesState){
                      var news = state.headlineData;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: news!.articles!.length,
                        itemBuilder: (context , index){
                          return GestureDetector(
                            onTap: (){
                              BlocProvider.of<NewsCubit>(context).getDetails(news.articles![index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: news.articles![index].urlToImage != null ? Image.network(news.articles![index].urlToImage!,fit: BoxFit.cover,) :
                                    Container(),
                                  ),
                                  Positioned(
                                    top: 50,
                                    left : 30,
                                    child: Text(news.articles![index].author == null ? 'by N/A' : 'by ${news.articles![index].author!}',
                                      style: const TextStyle(color: Colors.white,fontFamily: 'nunito_semi'),) ,
                                  ),
                                  Positioned(
                                    top: 80,
                                    left: 30,
                                    child: SizedBox(
                                        width : 300,
                                        child: Text(news.articles![index].title!,style: const TextStyle(color: Colors.white,
                                            fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'nunito_bold'),maxLines: 2,)),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 30,
                                    child: SizedBox(
                                      width : 300,
                                      child: Text(news.articles![index].content!,maxLines: 2,style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'nunito_semi'
                                      ),
                                      ),
                                    ),
                                  )
                                ],
                               ),
                            ),
                          );
                        },
                      );
                    } else if (state is LoadingState){
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black87,),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20,),
 */