import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/data/onboarding_data.dart';
import 'package:expenz_app/screens/onboarding/home_page.dart';
import 'package:expenz_app/screens/onboarding/shared_onboarding_pages.dart';
import 'package:expenz_app/screens/user_data_screen.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  // page controller
  final PageController _controller = PageController();
  bool showDetailsPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //onboarding screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index ==3;
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnboardingScreens(
                      title: OnboardingData.onbordingDataList[0].title, 
                      imagePath: OnboardingData.onbordingDataList[0].imagePath, 
                      description: OnboardingData.onbordingDataList[0].description),

                       SharedOnboardingScreens(
                      title: OnboardingData.onbordingDataList[1].title, 
                      imagePath: OnboardingData.onbordingDataList[1].imagePath, 
                      description: OnboardingData.onbordingDataList[1].description),

                       SharedOnboardingScreens(
                      title: OnboardingData.onbordingDataList[2].title, 
                      imagePath: OnboardingData.onbordingDataList[2].imagePath, 
                      description: OnboardingData.onbordingDataList[2].description),
                    
                  ],
                ),
                //page dot indicator
                Container(
                  alignment: Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey
                    ),
                  ),
                ),
                // navigation button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: !showDetailsPage ? GestureDetector(
                      onTap: () {
                        _controller.animateToPage(_controller.page!.toInt() + 1, duration: Duration(microseconds: 400), curve: Curves.easeInOut);
                      },
                      child: CustomButton(
                      buttonName: showDetailsPage ? "Get Started" : "Next", 
                      buttonColor: kMainColor),
                    ) : GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserDataScreen(),));
                      },
                      child: CustomButton(
                      buttonName: showDetailsPage ? "Get Started" : "Next", 
                      buttonColor: kMainColor),
                    ),
                  ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}