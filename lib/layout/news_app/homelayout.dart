import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/layout/news_app/cubit/cubit.dart';
import 'package:salahh/layout/news_app/cubit/states.dart';
import 'package:salahh/modules/news_app/search/search_screen.dart';
import 'package:salahh/shared/app_cubit/cubit.dart';
import 'package:salahh/shared/shared.component/component.dart';
import 'package:salahh/shared/shared.network/dio_helper.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(BuildContext context , NewsStates states){} ,
      builder:(BuildContext context , NewsStates states){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title : Text('News App'),
           actions: [
             IconButton(
                 onPressed: (){
                   navigateTo(context, SearchScreen());
                 },
                 icon: Icon(Icons.search)),
             IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
               onPressed: (){
                 AppCubit.get(context).changeAppTheme();
               },
             )],
          ),
          body: cubit.screens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeItem(index);
            },
            items:cubit.BottomNav,
            ),
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                //cubit.getBusines();
                //cubit.changeTheme();
              } ,
              child: Icon(Icons.add) ),


        );
      },
    );
  }
}
