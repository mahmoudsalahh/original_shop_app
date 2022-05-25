import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/models/categories_model.dart';
import 'package:salahh/models/home_model.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_cubit.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_states.dart';
import 'package:salahh/shared/shared.component/component.dart';

class ProductsScreen extends StatelessWidget{
  //const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit ,HomeStates>(
        builder: (context , state)=>
            ConditionalBuilder(
                condition:
                HomeCubit.get(context).categoriesModel != null && HomeCubit.get(context).homeModel != null && HomeCubit.get(context).favorites!.isNotEmpty,
                builder: (context)=>productsBuilder(HomeCubit.get(context).homeModel!,HomeCubit.get(context).categoriesModel!,context ),
                fallback: (context)=>Center(child: CircularProgressIndicator())),
        listener: (context , state){
          if(state is SuccesschangeFavoritesState){
            if(!state.model!.status! ){
              showToast(text: state.model!.Message!, state: ToastState.ERROR);
            }
          }
        });
  }

}
Widget productsBuilder(HomeModel model,CategoriesModel ctegoriesModel ,context) {
  return SingleChildScrollView(
    physics:BouncingScrollPhysics() ,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data.banners.map((e) =>
                Image(
                  image: NetworkImage('${e.image}'),
                )).toList(),
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: 3),
              initialPage: 0,
              viewportFraction: 1.0,
              reverse: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,

            )),
        SizedBox(height: 15.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold)),
              Container(
                height: 100.0,
                child: ListView.separated(
                    physics:BouncingScrollPhysics() ,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>builtListCategories(HomeCubit.get(context).categoriesModel!.data.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 20.0,),
                    itemCount: ctegoriesModel.data.data.length),
              ),
              SizedBox(height: 25.0,),
              Text('New Products',style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1/1.69,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children:
              List.generate(model.data.products.length,
                      (index) => buildGridProduct(model.data.products[index],context)

          )
          ),
        ),
      ],
    ),
  );

}
Widget buildGridProduct(ProductsModel model ,context) =>
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 220.0,
              ),
              if(model.discount !=0)
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name }',
                  style:TextStyle(fontSize: 14.0) ,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 15,),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model.price }',
                      style:TextStyle(fontSize: 13.0,color: Colors.blue) ,
                    ),
                    SizedBox(width: 10,),
                    if(model.discount !=0)
                    Text(
                      '${model.oldPrice }',
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
                              HomeCubit.get(context).changeFavorites(model.id);
                              print(model.id);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color:HomeCubit.get(context).favorites![model.id]! ? Colors.blue : Colors.grey,
                              size: 15.0,)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

        ],),
    );

Widget builtListCategories(DataModel model)=>
    Stack(
      alignment:AlignmentDirectional.bottomCenter ,
      children: [
        Image(
          height: 100,
          width: 100,
          image: NetworkImage(
            '${model.image}',
          ),),
        Container(
          padding: EdgeInsets.all(2.0),
          color: Colors.black.withOpacity(0.7),
          width: 100.0,
          child: Text(
              '${model.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style:TextStyle(fontSize: 15.0,color: Colors.white
              )),
        )
      ],
    );
