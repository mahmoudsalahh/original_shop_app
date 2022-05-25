
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_cubit.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_states.dart';
import 'package:salahh/modules/shop_app/search/search_screen.dart';
import 'package:salahh/shared/shared.component/component.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(

                title: Text('Salla'),
              actions: [Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
              )]
            ),
              body:  cubit.bottomScreen[cubit.currentIndex],
              bottomNavigationBar:
                    BottomNavigationBar(
                      currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeItem(index);
                },

                items: cubit.bottomNavBarItem,
              ),


          );
        },
        listener: (context, state) {
        });
  }
}