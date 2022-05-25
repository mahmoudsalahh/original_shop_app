
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/models/favorite_model.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_cubit.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_states.dart';

class FavoritScreen extends StatelessWidget{
  //const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit ,HomeStates>(
        builder: (context , state)=>
            ConditionalBuilder(
              condition: state is !LoudingFavoritesDataState,
              builder:(context) => ListView.separated(
                  physics:BouncingScrollPhysics() ,
                  itemBuilder: (context ,index)=>buildFavItem(HomeCubit.get(context).favoriteModel!.data.favoritesItem[index],context),
                  separatorBuilder: (context ,index)=>Divider(),
                  itemCount: HomeCubit.get(context).favoriteModel!.data.favoritesItem.length),
              fallback: (context)=>Center(child: CircularProgressIndicator()),


            ),
        listener: (context , state){});


  }
  Widget buildFavItem(Data model ,context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(image: NetworkImage('${model.product!.image}'),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if(model.product!.discount !=0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                        color: Colors.red,
                        child: Text('DISCOUNT',style: TextStyle(fontSize: 9.0 , color: Colors.white),),
                      ),
                    )
                ],
              ),
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.product!.name}',
                    style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold) ,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${model.product!.price}',
                        style:TextStyle(fontSize: 13.0,color: Colors.blue) ,
                      ),
                      SizedBox(width: 10,),
                      if(model.product!.discount !=0)
                        Text(
                          '${model.product!.oldPrice}',
                          style:TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ) ,


                        ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor:  Colors.grey[300]  ,
                        radius: 15.0,
                        child: Center(
                          child: IconButton(
                              onPressed: (){
                                HomeCubit.get(context).changeFavorites(model.product!.id);
                               // print(model.id);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: HomeCubit.get(context).favorites![model.product!.id]! ? Colors.blue : Colors.grey,
                                size: 15.0,)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

          ],),
      ),
    );
  }
}
