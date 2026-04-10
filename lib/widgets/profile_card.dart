import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  const ProfileCard({super.key, required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaulPadding),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kWhite,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: kBlack.withOpacity(0.3),

          )
        ]
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color.withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: color, size: 30,),
            ),
          ),
          const SizedBox(width: 30,),
          Text(title, style: TextStyle(color: kBlack.withOpacity(0.7), fontSize: 17, fontWeight: FontWeight.w600),)
        ],
      ),

    );
  }
}