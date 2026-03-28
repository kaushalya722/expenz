import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/screens/add_new_screen.dart';
import 'package:expenz_app/screens/budget_screen.dart';
import 'package:expenz_app/screens/home_page.dart';
import 'package:expenz_app/screens/profile_screen.dart';
import 'package:expenz_app/screens/transaction_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

//current page index
int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

  final List<Widget> pages = [
    AddNewScreen(),
    HomeScreen(),
    TransactionScreen(),
    // AddNewScreen(),
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