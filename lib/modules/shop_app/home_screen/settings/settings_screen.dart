
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_cubit.dart';
import 'package:salahh/modules/shop_app/home_screen/home_cubit/home_states.dart';
import 'package:salahh/modules/shop_app/login/login_screen.dart';
import 'package:salahh/shared/shared.component/component.dart';
import 'package:salahh/shared/shared.component/constant.dart';
import 'package:salahh/shared/shared.network/chase_helper.dart';

class SettingsScreen extends StatelessWidget{
  //const SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var PhoneController = TextEditingController();
  var confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
        listener: (context , state){
        },
        builder: (context , state){
         var  model = HomeCubit.get(context).userModel;
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          PhoneController.text = model.data!.phone!;

          return ConditionalBuilder(
            condition:model != null ,
           builder:  (context)=>Scaffold(
             body: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       CircleAvatar(
                         backgroundImage: AssetImage('Assets/images/onboarding1.jpg',),
                         radius: 70.0,
                       ),
                       SizedBox(
                         height: 25.0,
                       ),
                       defaulttextformfeild(
                           controller: nameController,
                           label: 'Name',
                           validate: (value) {
                             if (value.isEmpty) {
                               return 'Enter Your Name';
                             }
                             return null;
                           },
                           prefix: Icons.person),
                       SizedBox(
                         height: 20.0,
                       ),
                       defaulttextformfeild(
                           controller: emailController,
                           label: 'Email',
                           validate: (value) {
                             if (value.isEmpty) {
                               return 'Email is Wrong';
                             }
                             return null;
                           },
                           prefix: Icons.email_outlined),
                       SizedBox(height: 20.0,),
                       defaulttextformfeild(
                           controller: PhoneController,
                           label: 'Phone',
                           validate: (value) {
                             if (value.isEmpty) {
                               return 'Enter Your Phone';
                             }
                             return null;
                           },
                           prefix: Icons.phone),
                       SizedBox(height: 30.0,),
                       Center(
                           child: defaultButton(
                             onpressed: (){
                               CacheHelper.removeData(key:token);
                               navigateAndRemoveUntil(context, LoginScreen(),);
                             },
                             text: 'Logout',)),

                     ],
                   ),
                 ),
               ),
             ),
           ),
           fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        }
            );


  }
}
