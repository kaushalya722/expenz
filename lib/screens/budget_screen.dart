import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/model/expense_model.dart';
import 'package:expenz_app/model/income_model.dart';
import 'package:expenz_app/widgets/category_card.dart';
import 'package:expenz_app/widgets/pie_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenceCategory, double> expenceCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;

  const BudgetScreen({super.key, required this.expenceCategoryTotals, required this.incomeCategoryTotals});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {

  int _selectedOption = 0;

  //method to find the category color from the category
  Color getCategoryColor(dynamic category){
    if(category is ExpenceCategory){
      return expenceCategoriesColors[category]!;
    }else{
      return incomeCategoryColors[category]!;
    }
  }
  @override
  Widget build(BuildContext context) {

    final data = _selectedOption == 0 ? widget.expenceCategoryTotals : widget.incomeCategoryTotals;
    return Scaffold(
      appBar: AppBar(  
        centerTitle: true,
        title: 
        const Text("Financial Report", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kBlack),)),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: kDefaulPadding, vertical: kDefaulPadding/2),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: kBlack.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOption = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                      color: _selectedOption == 0 ? kRed : kWhite,
                      ),
                      child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
                      child: Text("Expense", style: TextStyle(
                        color: _selectedOption == 0 ? kWhite : kBlack, 
                        fontSize: 16, 
                        fontWeight: FontWeight.w700),),
                      ),
                      
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOption = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                      color: _selectedOption == 0 ? kWhite : kGreen,
                      ),
                      child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
                      child: Text("Income", style: TextStyle(
                        color: _selectedOption == 1 ? kWhite : kBlack, 
                        fontSize: 16, 
                        fontWeight: FontWeight.w700),),
                      ),
                      
                    ),
                  )
                ],
              ),
              
            ),
            ),
            const SizedBox(height: 20,),
            //pie chart
            Chart(
              expenceCategoryTotals: widget.expenceCategoryTotals, 
              incomeCategoryTotals: widget.incomeCategoryTotals, 
              isExpense: _selectedOption == 0,),

              SizedBox(height: 20,),
              //list of category
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final Category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                     return CategoryCard(
                      title: Category.name, 
                      amount: total, 
                      total: data.values.reduce((value, element) => value+element,), 
                      progressColor: getCategoryColor(Category), 
                      isExpence: _selectedOption == 0,);
                },),
              )
          ],
        ),
      )),
    );
  }
}