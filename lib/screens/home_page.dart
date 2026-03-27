import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/income_expenz_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


//for store the user name
String username = "";

@override
  void initState() {
    //get the user name from the shared prefereneces
    UserService.getUserData().then((value) {
      if(value["username"] != null){
       setState(() {
         username = value["username"]!;
       });

      }
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // main column
        child:Column(
          children: [
            //purple background card
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(color: kMainColor.withOpacity(0.6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
              )),
              child: Padding(
                padding: const EdgeInsets.all(kDefaulPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: kMainColor,border: Border.all(
                            color: kMainColor,
                            width: 3,
                          )),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset("assets/images/user.jpg", width: 50, fit: BoxFit.cover,),
                            
                            ),
                        ),
                        SizedBox(width: 20,),
                        Text("Welcome $username", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kBlack),),
                        SizedBox(width: 50,),
                        IconButton(onPressed: (){}, icon: Icon(Icons.notifications, size: 30, color: kMainColor,))
                      ],
                    ),
                    SizedBox(height: 23,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IncomeExpenceCard(
                          title: "Income", 
                          amount: 1200, 
                          imageUrl: "assets/images/income.png", 
                          BgColor: kGreen),
                          IncomeExpenceCard(
                          title: "Expense", 
                          amount: 2300, 
                          imageUrl: "assets/images/expense.png", 
                          BgColor: kRed),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ) ),
      
    );
  }
}