import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/cubit/app_cubit.dart';
import 'package:news_app_flutter/cubit/app_cubit_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  final _searchKey = GlobalKey<FormState>();

  final _queries = [
    'Health',
    'Sport',
    'Politics',
    'Economy',
    'Education'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.all(20),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
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
                      hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black45),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      suffixIcon: Icon(Icons.search,size: 25,color: Colors.black45,)
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Latest News',style: TextStyle(color: Colors.black,fontSize: 20,
              fontFamily: 'nunito_semibold'),),
              const SizedBox(height: 20,),
              SizedBox(
                width: 350,
                height: 250,
                child :  BlocBuilder<NewsCubit,NewsState>(
                  builder: (context , state){
                    if(state is LoadedState){
                      var news = state.newsModel;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: news!.articles!.length,
                        itemBuilder: (context , index){
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(news.articles![index].urlToImage!,fit: BoxFit.cover,),
                                ),
                                Positioned(
                                  top: 50,
                                  left : 30,
                                  child: Text(news.articles![index].author == null ? 'by N/A' : 'by ' + news.articles![index].author,
                                  style: TextStyle(color: Colors.white),) ,
                                ),
                                Positioned(
                                  top: 80,
                                  left: 30,
                                  child: SizedBox(
                                      width : 300,
                                      child: Text(news.articles![index].title!,style: const TextStyle(color: Colors.white,
                                      fontSize: 20,fontWeight: FontWeight.bold),)),
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

                                     ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is LoadingState){
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black87,),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black87,),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
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
                        child: Text(_queries[index],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      )),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Expanded(
                child: SizedBox(
                  width: 350,
                  height: 250,
                  child :  BlocBuilder<NewsCubit,NewsState>(
                    builder: (context , state){
                      if(state is LoadedState){
                        var news = state.newsModel;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: news!.articles!.length,
                          itemBuilder: (context , index){
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(news.articles![index].urlToImage!,fit: BoxFit.cover,),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 30,
                                    child: SizedBox(
                                        width : 300,
                                        child: Text(news.articles![index].title!,style: const TextStyle(color: Colors.white,
                                            fontSize: 17,fontWeight: FontWeight.bold),maxLines: 2,)),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 30,
                                    right : 30,
                                    child: Row(
                                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(news.articles![index].author == null ? 'by N/A' : 'by ${news.articles![index].author}'),
                                        Text(news.articles![index].publishedAt!)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state is LoadingState){
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black87,),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black87,),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
