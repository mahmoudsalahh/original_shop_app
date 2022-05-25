
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/models/categories_model.dart';
import 'package:salahh/models/home_model.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_cubit.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_states.dart';

class CategoryScreen extends StatelessWidget {
  //const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit ,HomeStates>(
        builder: (context , state)=>
            ListView.separated(
                physics:BouncingScrollPhysics() ,
                itemBuilder: (context ,index)=>categoriesBuilder(HomeCubit.get(context).categoriesModel!.data.data[index]),
                separatorBuilder: (context ,index)=>Divider(),
                itemCount: HomeCubit.get(context).categoriesModel!.data.data.length),
        listener: (context , state){});
}

}
Widget categoriesBuilder( DataModel model){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          height: 80,
          width: 80,
          image: NetworkImage(
            '${model.image}',
          ),),
        SizedBox(width: 30.0,),
        Text(
            '${model.name}',
            //textAlign: TextAlign.center,
            style:TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold
            )),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))

      ],
    ),
  );
}