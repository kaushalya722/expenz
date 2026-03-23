import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/data/onboarding_data.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreens extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const SharedOnboardingScreens({
    super.key, 
    required this.title, 
    required this.imagePath, 
    required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaulPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 300, fit: BoxFit.cover,),
          SizedBox(height: 20,),
          Text(textAlign: TextAlign.center,title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700,),),
          SizedBox(height: 20,),
          Text(textAlign: TextAlign.center,description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kGrey),)
      
        ],
      ),
    );
  }
}