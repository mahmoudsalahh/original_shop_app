import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahh/modules/shop_app/home_screen/home_screen.dart';
import 'package:salahh/modules/shop_app/login/login_cubit/cubit.dart';
import 'package:salahh/modules/shop_app/login/login_cubit/states.dart';
import 'package:salahh/modules/shop_app/register/register_cubit/cubit.dart';
import 'package:salahh/modules/shop_app/register/register_cubit/states.dart';
import 'package:salahh/shared/shared.component/component.dart';
import 'package:salahh/shared/shared.network/chase_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool obsecure = true;


  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (BuildContext context)=>RegisterCubit(),
         child: BlocConsumer<RegisterCubit, ShopRegisterStates>(
        listener: (context , state){
          if (state is ShopRegisterSucceesState) {
            if (state.loginModel!.status) {
              CacheHelper.saveData(key: 'token', value: state.loginModel!.data!.token).then((value) {
                navigateTo(context, HomeScreen());
              });
            } else {
              showToast(
                  text: state.loginModel!.message!,
                  state: ToastState.ERROR);
            }
          }
        },
    builder: (context , state)=>
      Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REGISTER',
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.0,),
                  Text(
                    'Register Now to browse Our Offers',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30.0,
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
                    controller: passwordController,
                    label: 'Password',
                    validate: (value) {
                      if(value.isEmpty){
                        return 'Password is Too Short';
                      }
                      return null ;
                    },
                    obsecureText: obsecure,
                    suffixPressed: (){
                      setState(() {
                        obsecure = !obsecure;
                      });
                    },
                    prefix: Icons.lock,
                    suffix: obsecure? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  ),
                  SizedBox(height: 20.0,),
                  defaulttextformfeild(
                    controller: phoneController,
                    label: 'Phone',
                    validate: (value) {
                      if(value.isEmpty){
                        return 'Phone is not correct';
                      }
                      return null ;
                    },
                    prefix: Icons.phone,
                  ),
                  SizedBox(height: 30.0,),
                  ConditionalBuilder(
                    condition: state is! ShopRegisterLoudingState,
                    builder:(context) => defaultButton(
                        onpressed: (){
                          if(formKey.currentState!.validate()){
                            RegisterCubit.get(context).registerUser(
                                email: emailController.text,
                                password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );

                          } },
                        text: 'REGISTER' ),
                    fallback: (context)=>Center(child: CircularProgressIndicator()),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    )));
  }
}
