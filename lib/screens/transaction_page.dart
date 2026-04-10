
import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/model/expense_model.dart';
import 'package:expenz_app/model/income_model.dart';
import 'package:expenz_app/widgets/expence_card.dart';
import 'package:expenz_app/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expence> expencesList;
  final List<Income> incomeList;
  final void Function(Expence) onDismissedExpence;
  final void Function(Income) onDismissedIncome;

  const TransactionScreen({super.key, required this.expencesList, required this.onDismissedExpence, required this.onDismissedIncome, required this.incomeList});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(kDefaulPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text("See your financial report", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: kMainColor,
            ),),

            const SizedBox(height: 20,),

            const Text("Expenses", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kBlack,
            ),),
            const SizedBox(height: 20,),
            //show all the expenses
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    widget.expencesList.isEmpty ? Text("No expences added yet, add some expences to see here", style: TextStyle(fontSize: 16, color: kGrey),): 
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.expencesList.length,
                      itemBuilder: (context, index) {
                      final expence = widget.expencesList[index];

                      return Dismissible(
                        key: ValueKey(expence),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          setState(() {
                            widget.onDismissedExpence(expence);
                          });
                        },
                        child: ExpenceCard(
                          title: expence.title, 
                          date: expence.date, 
                          amount: expence.amount, 
                          category: expence.category, 
                          description: expence.description, 
                          time: expence.time),
                      );
                    },)
                  ],
                ),
              ),
            ),

            //income
            const SizedBox(height: 20,),
            const Text("Income", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kBlack,
            ),),
            const SizedBox(height: 20,),
            //show all the expenses
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    widget.incomeList.isEmpty ? Text("No incomes added yet, add some incomes to see here", style: TextStyle(fontSize: 16, color: kGrey),): 
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.incomeList.length,
                      itemBuilder: (context, index) {
                      final income = widget.incomeList[index];

                      return Dismissible(
                        key: ValueKey(income),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          setState(() {
                            widget.onDismissedIncome(income);
                          });
                        },
                        child: IncomeCard(
                          title: income.title, 
                          date: income.date, 
                          amount: income.amount, 
                          category: income.category, 
                          description: income.description, 
                          time: income.time),
                      );
                    },)
                  ],
                ),
              ),
            ),

          ],
        ),
        ),
        ),
    );
  }
}