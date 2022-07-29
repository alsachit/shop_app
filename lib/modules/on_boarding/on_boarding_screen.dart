import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/shop_login/shop_login.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image,required this.title,required this.body});
}


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<BoardingModel> onBoardingItems = [
    BoardingModel(
        image: 'assets/images/onboarding1.png' ,
        title: 'On Boarding 1 Title' ,
        body: 'On Boarding 1 body'
    ),
    BoardingModel(
        image: 'assets/images/onboarding2.png' ,
        title: 'On Boarding 2 Title' ,
        body: 'On Boarding 2 body'
    ),
    BoardingModel(
        image: 'assets/images/onboarding3.png' ,
        title: 'On Boarding 3 Title' ,
        body: 'On Boarding 3 body'
    ),
  ];

  var pageController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    }).catchError((error){
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text('SKIP', style: TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildBoardingItem(onBoardingItems[index]),
                itemCount: onBoardingItems.length,
                onPageChanged: (index){
                  if (index == onBoardingItems.length - 1) {
                    setState((){
                      isLast = true;
                    });
                  }else {
                    setState((){
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: onBoardingItems.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if (isLast) {
                      submit();
                    }else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
     const SizedBox(height: 30,),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
     const SizedBox(height: 15,),
      Text(
        model.body,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
      ),
      const SizedBox(height: 40,),
    ],
  );

}
