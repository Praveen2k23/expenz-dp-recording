import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';

class SharedOnboardingScreen extends StatelessWidget {

  final String title;
  final String imagePath;
  final String description;

  const SharedOnboardingScreen({super.key, required this.title, required this.imagePath, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefalutPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 300, fit: BoxFit.cover),
          SizedBox(height: 20,),
      
          Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),
      
          Text(description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: kGreen,
            fontWeight: FontWeight.w400
          ),),
      
      
        ],
      ),
    );
  }
}