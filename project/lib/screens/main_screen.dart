import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/screens/add_new_screen.dart';
import 'package:project/screens/budget_screen.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/profile_screen.dart';
import 'package:project/screens/transaction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentPageIndex = 0;

  final List <Widget> pages = [
    HomeScreen(),
    TransactionScreen(),
    AddNewScreen(),
    BudgetScreen(),
    ProfileScreen()

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex ,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600
        ),
        items: [BottomNavigationBarItem(

        icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
        icon: Icon(Icons.list_rounded), label: "Transactions"),

      BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
            color: kMainColor,
            shape: BoxShape.circle
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.add,size: 35,color: kWhite,),
          )), label: "Add"),

      BottomNavigationBarItem(
        icon: Icon(Icons.rocket), label: "Budget"),
      BottomNavigationBarItem(
        icon: Icon(Icons.person), label: "Profile"),
        
        
        
        
        ]),
        body: pages[_currentPageIndex],

    );
  }
}