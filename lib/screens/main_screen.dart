import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/model/expense_model.dart';
import 'package:expenz_app/model/income_model.dart';
import 'package:expenz_app/screens/add_new_screen.dart';
import 'package:expenz_app/screens/budget_screen.dart';
import 'package:expenz_app/screens/home_page.dart';
import 'package:expenz_app/screens/profile_screen.dart';
import 'package:expenz_app/screens/transaction_page.dart';
import 'package:expenz_app/services/expence_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

//current page index
int _currentPageIndex = 0;

List<Expence> expenceList = [];
List<Income> incomeList = [];

//function to fetch expences
void fetchAllExpences () async {
  List<Expence> loadedExpences = await ExpenceService().loadExpences();
  setState(() {
    expenceList = loadedExpences;
     
  });
  // print(expenceList.length);
}

// function to fetch all incomes
void fetchAllIncomes() async {
  List<Income> loadedIncomes = await IncomeService().loadIncomes();
  setState(() {
    incomeList = loadedIncomes;
     
  });
}

//function to add new income
void addNewIncome (Income newIncome){
  IncomeService().saveIncomes(newIncome, context);

  setState(() {
    incomeList.add(newIncome);
   
  });
}

//Function to add a new expence
void  addNewExpence (Expence newExpence){
  ExpenceService().saveExpences(newExpence, context);

  //update the list of expence
  setState(() {
    expenceList.add(newExpence);
   
  });
}

@override
  void initState() {
    
    super.initState();
    setState(() {
      fetchAllExpences();
      fetchAllIncomes();
    });
  }

  //function to remove a expence
  void removeExpence (Expence expence){
    ExpenceService().deleleExpence(expence.id, context);
    setState(() {
      expenceList.remove(expence);
    });
  }

  void removeIncome(Income income){
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }
  
  //category tatal expense
  Map<ExpenceCategory, double> calculateExpenseCategories() {
    Map<ExpenceCategory, double> categoryTotals = {
      ExpenceCategory.food: 0,
      ExpenceCategory.health : 0,
      ExpenceCategory.shopping : 0,
      ExpenceCategory.subscription : 0,
      ExpenceCategory.transport : 0,
    };

    for(Expence expence in expenceList){
      categoryTotals[expence.category] = 
      categoryTotals[expence.category]! + expence.amount;

    }
    return categoryTotals;
  }

  //category tatal Income
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotals = {
     IncomeCategory.freelance : 0,
     IncomeCategory.passive : 0,
     IncomeCategory.sales : 0,
     IncomeCategory.salary : 0,
    };

    for(Income income in incomeList){
      categoryTotals[income.category] = 
      categoryTotals[income.category]! + income.amount;

    }
    return categoryTotals;
  }



  @override
  Widget build(BuildContext context) {

  final List<Widget> pages = [
  
  HomeScreen(
    
    expencesList: expenceList,
    incomeList: incomeList,
  ),

   TransactionScreen(
    onDismissedIncome: removeIncome,
    expencesList: expenceList,
    incomeList: incomeList,
    onDismissedExpence: removeExpence,
   ),
    
  AddNewScreen(
      addExpence: addNewExpence,
      addIncome: addNewIncome,

    ),
  BudgetScreen(
    expenceCategoryTotals: calculateExpenseCategories(),
    incomeCategoryTotals: calculateIncomeCategories(),
  ),
  ProfileScreen(),
  
  ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (Index) {
          setState(() {
            _currentPageIndex = Index;
          });
        },
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        items: [ 
          BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.list_rounded),
          label: "Transactions",
          ),
          BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(color: kMainColor, shape: BoxShape.circle),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.add, color: kWhite, size: 30,)),
            label: "",
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.rocket),
          label: "Budget",
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
          ),
          ],
          ),
          body: pages[_currentPageIndex],
    );
  }
}