import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/model/expense_model.dart';
import 'package:expenz_app/model/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<ExpenceCategory, double> expenceCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  final bool isExpense;

  const Chart({super.key, required this.expenceCategoryTotals, required this.incomeCategoryTotals, required this.isExpense});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  //sections data
  List<PieChartSectionData> getSections() {
    if(widget.isExpense){
       return [
        PieChartSectionData(
          color: expenceCategoriesColors[ExpenceCategory.food],
          value: widget.expenceCategoryTotals[ExpenceCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenceCategoriesColors[ExpenceCategory.health],
          value: widget.expenceCategoryTotals[ExpenceCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenceCategoriesColors[ExpenceCategory.shopping],
          value: widget.expenceCategoryTotals[ExpenceCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenceCategoriesColors[ExpenceCategory.subscription],
          value: widget.expenceCategoryTotals[ExpenceCategory.subscription] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenceCategoriesColors[ExpenceCategory.transport],
          value: widget.expenceCategoryTotals[ExpenceCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
       ];
    } else{
      return [
         PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategoryTotals[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
          PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomeCategoryTotals[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
          PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomeCategoryTotals[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
          PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.sales],
          value: widget.incomeCategoryTotals[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
    
  }
  @override
  Widget build(BuildContext context) {
    final pieChartData = PieChartData(
       sectionsSpace: 0,
       centerSpaceRadius: 70,
       startDegreeOffset: -90,
       sections: getSections(),
       borderData: FlBorderData(
        show: false,
       )
    );
    return Container(
       height: 250,
       padding: EdgeInsets.all(kDefaulPadding),
       decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
       ),
       child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("70%", style: TextStyle(color: kBlack, fontWeight: FontWeight.w700),),
              SizedBox(height: 8,),
              Text("of 100%", style: TextStyle(color: kGrey, ),)
            ],
          )

        ],
       ),
    );
  }
}