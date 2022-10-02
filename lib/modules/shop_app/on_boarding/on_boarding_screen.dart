import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled1/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

import '../../../shared/styles/colors.dart';

class BoardingModel{
  late final  String image;
  late final String title;
  late final String body;

  BoardingModel({required this.image, required this.title, required this.body,}      );

}
class OnBoardingScreen extends StatefulWidget {

   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var boardController =PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
      image:'assets/images/onboard_1.jpg',
      title: 'on board 1 ',
      body:'on board 1 body',
    ),
    BoardingModel(
      image:'assets/images/onboardin9.jpg',
      title: 'on board 2 ',
      body:'on board 2 body',
    ),
    BoardingModel(
      image:'assets/images/onboarding2.png',
      title: 'on board 3 ',
      body:'on board 3 body',
    ),
  ] ;
  bool isLast = false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        NavigateAndFinish(context, ShopLoginScreen());
      }
    });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextBotton(
              function: submit,
              text: 'Skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                    setState((){
                      isLast=true;
                    });
                  }else{

                    setState((){
                      isLast=false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,

              ),
            ),
           const SizedBox(
             height: 40.0,
           ),
            Row(
              children:  [
                SmoothPageIndicator(
                  controller: boardController,
                  effect:  const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    else{
                      boardController.nextPage(duration:const Duration(
                        milliseconds: 500,) ,
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }

                  },
                  child: Icon(Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children:[

      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),),
      ),
      const  SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style:const TextStyle(
          fontSize: 24.0,

        ),),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.body}',
        style:const TextStyle(
          fontSize: 14.0,


        ),),
      const  SizedBox(
        height: 30.0,
      ),

    ],
  );
}
