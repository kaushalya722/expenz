import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/screens/onboarding_screens.dart';
import 'package:expenz_app/services/expence_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String username = "";
  String email = "";

@override
  void initState() {
    UserService.getUserData().then((value) {
      if(value['username'] != null && value['email'] != null){
          setState(() {
          username = value['username']!;
          email = value['email']!;
          });
      }
    },);
    super.initState();
  }

  //open scaffold messenger for logout
  void _showBottomSheet ( BuildContext context){
    showModalBottomSheet(
      backgroundColor: kWhite,
      context: context, 
      builder: (context) {
      return Container(
        height: 200,
        padding: EdgeInsets.all(kDefaulPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Are you sure you want to log out?", style: TextStyle(fontSize: 18, color: kBlack, fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kGreen),
                  ),
                  onPressed: () async{
                    //clear the user data
                    await UserService.clearUserData();
                    // clear all expences

                    if(context.mounted){
                      await ExpenceService().deleteAllExpences(context);
                      await IncomeService().deleteAllIncomes(context);

                      //navigate to the onboarding screen
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) => OnboardingScreen(),), 
                      (route) => false,);
                    }
                    
              
                  }, 
                  child: Text("Yes",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kWhite),),),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kRed),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  child: Text("No", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kWhite),),),
              ],
            ),
          ],
        ),
      );
    },);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
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
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome $username", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kBlack),),
                      Text(" $email", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: kGrey),),
                    ],
                  ),
                  SizedBox(width: 50,),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: kMainColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      ),
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.edit, size: 30, color: kMainColor,)))
                ],
              ),
              SizedBox(height: 30,),
              ProfileCard(
                icon: Icons.money,
                title: "My Wallet",
                color: kMainColor,
              ),
              ProfileCard(
                icon: Icons.settings,
                title: "Setting",
                color: kYellow,
              ),
              ProfileCard(
                icon: Icons.input,
                title: "Export Data",
                color: kGreen,
              ),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: ProfileCard(
                  icon: Icons.logout,
                  title: "Log Out",
                  color: kRed,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}