import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/layout/news_app/cubit/cubit.dart';
import 'package:salahh/layout/news_app/cubit/states.dart';
import 'package:salahh/shared/shared.component/component.dart';
class Business extends StatefulWidget {
  @override
  State<Business> createState() => _BusinessState();
}
class _BusinessState extends State<Business> {
  @override
  Widget build(BuildContext context) {
    var list =NewsCubit.get(context).business;
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit , NewsStates>(
          builder: (BuildContext context , NewsStates state)=>
              /*ListView.builder(
              itemCount: NewsCubit.get(context).business.length ,
              itemBuilder: (context ,index )=>Text('mahmoud')),*/
           ListView.separated(
              itemBuilder: (context , index)=>NewsArtical(list[index],context),
              separatorBuilder: (context , index)=> Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: 1.0,
                  color: Colors.black,
                ),
              ),
              itemCount:list.length) ,
          listener:(BuildContext context , NewsStates state){} ),

    );
  }
}
