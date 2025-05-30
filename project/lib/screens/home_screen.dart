import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';
import 'package:project/services/user_services.dart';
import 'package:project/widgets/income_expence_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String username = "";

  @override
  void initState() {
    UserServices.getUserData().then((value) {
      if(value["username"] != null){
        setState(() {
          username = value['username']!;
          
        });
        
      }
    },);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kMainColor,
                              border: Border.all(
                                color: kMainColor,
                                width: 3
                      
                              )
                            ),
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(100),
                              child: Image.asset("assets/images/user.jpg",width: 50, fit: BoxFit.cover,),
                            ),
                          ),
                      
                          SizedBox(width: 20,),
                          Text("Welcome $username", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                      
                          SizedBox(width: 20,),
                      
                          IconButton(onPressed: () {
                            
                          }, icon: Icon(Icons.notifications,color: kMainColor,size: 30,))
                      
                          
                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceCard(
                              title: "Income",
                              amount: 1200,
                              bgColor: const Color.fromARGB(255, 5, 121, 78),
                              imageUrl: "assets/images/income.png",
                            ),
                          
                          IncomeExpenceCard(
                            title: "Expense",
                            amount: 2300,
                            bgColor: kRed,
                            imageUrl: "assets/images/expense.png",
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
        )),

    );
  }
}