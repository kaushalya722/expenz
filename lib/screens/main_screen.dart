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
     print(expenceList.length);
  });
  // print(expenceList.length);
}

// function to fetch all incomes
void fetchAllIncomes() async {
  List<Income> loadedIncomes = await IncomeService().loadIncomes();
  setState(() {
    incomeList = loadedIncomes;
     print(incomeList.length);
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



  @override
  Widget build(BuildContext context) {

  final List<Widget> pages = [
   
    HomeScreen(),
    TransactionScreen(),
     AddNewScreen(
      addExpence: addNewExpence,
      addIncome: addNewIncome,

    ),
    BudgetScreen(),
    ProfileScreen()
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