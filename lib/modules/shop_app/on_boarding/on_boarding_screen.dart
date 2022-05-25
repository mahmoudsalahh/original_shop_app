import 'package:flutter/material.dart';
import 'package:salahh/modules/shop_app/login/login_screen.dart';
import 'package:salahh/shared/shared.component/component.dart';
import 'package:salahh/shared/shared.network/chase_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingModel {
  final String image;
  final String text1;
  final String text2;
  OnBoardingModel({required this.image , required this.text1 ,required this.text2});
}

class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  var isLast = false;

  List <OnBoardingModel> list = [
    OnBoardingModel(
      image: 'Assets/images/onboarding1.jpg',
      text1: 'OnBoarding Title 1 ',
      text2: 'Onboarding Title 1 ',
        ),
    OnBoardingModel(
      image: 'Assets/images/onboarding1.jpg',
      text1: 'OnBoarding Title 2 ',
      text2: 'Onboarding Title 2 ',
    ),
    OnBoardingModel(
      image: 'Assets/images/onboarding1.jpg',
      text1: 'OnBoarding Title 3 ',
      text2: 'Onboarding Title 3 ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              text:'SKIP', onpressed: (){
                CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
                  if (value){
                    navigateAndRemoveUntil(context, LoginScreen());
                  }
                });

          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index){
                if(index==list.length-1){
                  setState(() {
                    isLast = true ;
                  });
                }
                else{
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context , index) =>buildBoardingItems(list[index]),
              itemCount: list.length,
            ),
          ),
            SizedBox(height: 35.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: list.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    dotColor: Colors.grey,
                    expansionFactor: 4.0,
                    spacing: 5.0,
                  ),

                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: (){
                    if(isLast == true){
                      navigateAndRemoveUntil(context, LoginScreen());
                    }else{
                      boardController.nextPage(
                          duration: Duration(
                              milliseconds: 750
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
                  backgroundColor: Colors.blue,),

              ],
            ),



          ],
        ),
      ),

    );
  }
}
Widget buildBoardingItems (OnBoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
Expanded(child: Image(image: AssetImage('${model.image}'))),
SizedBox(height: 20.0,),
Text('${model.text1}', style: TextStyle(fontSize: 25.0 , fontWeight: FontWeight.bold)),
SizedBox(height: 15.0,),
Text('${model.text2}', style: TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold)),
      SizedBox(height: 40.0,),

    ]
);
