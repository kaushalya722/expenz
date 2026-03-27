import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:flutter/material.dart';

class IncomeExpenceCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imageUrl;
  final Color BgColor;
  const IncomeExpenceCard({
    super.key, 
    required this.title, 
    required this.amount, 
    required this.imageUrl, 
    required this.BgColor});

  @override
  State<IncomeExpenceCard> createState() => _IncomeExpenceCardState();
}

class _IncomeExpenceCardState extends State<IncomeExpenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(color:widget.BgColor , borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(kDefaulPadding),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Image.asset(widget.imageUrl, width: 70,),
              ),
            ),
            SizedBox(width: 10,), 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: TextStyle(fontSize: 17, color: kWhite, fontWeight: FontWeight.w500),),
                Text("\$ ${widget.amount.toStringAsFixed(0)}", style: TextStyle(fontSize: 20, color: kWhite, fontWeight: FontWeight.bold),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}