import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/data/onboarding_data.dart';
import 'package:project/screens/onboarding/front_page.dart';
import 'package:project/screens/shared_onboarding_screen.dart';
import 'package:project/screens/user_data_screen.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  //Page Controller

final PageController _controller = PageController();
bool showDetailsPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[0].title, 
                      imagePath: OnboardingData.onboardingDataList[0].imagePath, 
                      description: OnboardingData.onboardingDataList[0].description),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[1].title, 
                      imagePath: OnboardingData.onboardingDataList[1].imagePath, 
                      description: OnboardingData.onboardingDataList[1].description),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[2].title, 
                      imagePath: OnboardingData.onboardingDataList[2].imagePath, 
                      description: OnboardingData.onboardingDataList[2].description),

                  ],
                ),


                Container(
                  alignment: Alignment(0, 0.70),
                  child: SmoothPageIndicator(controller: _controller
                  , count: 4,
                  effect: WormEffect(
                    activeDotColor: kMainColor,
                    dotColor: kLightGrey
                  ),),
                ),

                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, ),
                    child:!showDetailsPage ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.animateToPage(
                         _controller.page!.toInt()+1 , duration: Duration(milliseconds: 400), 
                         curve: Curves.easeInOut);
                        });
                      },
                      child: CustomButton(
                        buttonName: showDetailsPage ? "Get Started" : "Next",
                        buttonColor: kMainColor),
                    )

                   : GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: 
                        (context) => UserDataScreen(),));
                      },
                      child: CustomButton(
                        buttonName: showDetailsPage ? "Get Started" : "Next",
                        buttonColor: kMainColor),
                    ),
                  ))
              ],
            ),
          )
        ],
      ),
    );
  }
}