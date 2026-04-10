import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/model/expense_model.dart';
import 'package:expenz_app/model/income_model.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/expence_card.dart';
import 'package:expenz_app/widgets/income_expenz_card.dart';
import 'package:expenz_app/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expence> expencesList;
  final List<Income> incomeList;
  const HomeScreen({super.key, required this.expencesList, required this.incomeList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


//for store the user name
String username = "";
double expenceTotal = 0;
double incomeTotal = 0;

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

  setState(() {
    //total amount of expences
    for(var i = 0; i< widget.expencesList.length; i++){
      expenceTotal = expenceTotal + widget.expencesList[i].amount;
      //(expenceTotal += widjet.expenceList[i].amount)
    }

    //total amount of incomes
    for(var j = 0; j<widget.incomeList.length; j++){
      incomeTotal += widget.incomeList[j].amount;
    }
  });



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // main column
        child:SingleChildScrollView(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
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
                            amount: incomeTotal, 
                            imageUrl: "assets/images/income.png", 
                            BgColor: kGreen),
                            IncomeExpenceCard(
                            title: "Expense", 
                            amount: expenceTotal, 
                            imageUrl: "assets/images/expense.png", 
                            BgColor: kRed),
                        ],
                      )
                    ],
                  ),
                ),
              ),
          
              //line chart
              const Padding(padding: EdgeInsets.all(kDefaulPadding,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Spend Frequency", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  LineChartSample(),
          
                ],
              ),
              ),
              //recent transaction
          
              Padding(padding: EdgeInsets.symmetric(horizontal: kDefaulPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recent Transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  const SizedBox(height: 20,),
                  Column(
                    
                    children: [
                      widget.expencesList.isEmpty ? Text("No expences added yet, add some expences to see here", style: TextStyle(fontSize: 16, color: kGrey),): 
                      ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.expencesList.length,
                      itemBuilder: (context, index) {
                      final expence = widget.expencesList[index];

                      return ExpenceCard(
                        title: expence.title, 
                        date: expence.date, 
                        amount: expence.amount, 
                        category: expence.category, 
                        description: expence.description, 
                        time: expence.time);
                    },)
                    ],
                  )
                ],
              ),
              ),
            ],
          ),
        ) ),
      
    );
  }
}