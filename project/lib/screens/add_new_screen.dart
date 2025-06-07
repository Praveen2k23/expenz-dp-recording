import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';
import 'package:project/model/expens_model.dart';
import 'package:project/model/income_model.dart';
import 'package:project/widgets/custom_button.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _selectedMethods = 0;
  ExpenceCategory _expenceCategory = ExpenceCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();


  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethods == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefalutPadding),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// Expense Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethods = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethods == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _selectedMethods == 0 ? kWhite : kBlack,
                              ),
                            ),
                  
                          ),
                        ),
                  
                        /// Income Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethods = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethods == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: Text(
                            "Income",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedMethods == 1 ? kWhite : kBlack,
                            ),
                          ),
                  
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("How Much?",style: TextStyle(
                          color: kLightGrey.withOpacity(0.8),
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),),
                  
                                          TextField(
                    style: TextStyle(
                      fontSize: 60,
                      color: kWhite,
                      fontWeight: FontWeight.bold
                    ),
                  
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(
                        color: kWhite,
                        fontSize: 60,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  )
                      ],
                    ),
                  ),
                ),
        
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                    
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20) )
                  ),

                  child: Padding(
  padding: const EdgeInsets.all(20),
  child: Form(
    child: Column(
      children: [
        DropdownButtonFormField<dynamic>(
          decoration: InputDecoration(
            labelText: 'Select Category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: kDefalutPadding, // make sure this constant exists
              horizontal: 20,
            ),
          ),
          items: _selectedMethods == 0
              ? ExpenceCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList()
              : IncomeCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),

                value:  
                _selectedMethods == 0 ? _expenceCategory : _incomeCategory ,
          onChanged: (value) {
            // Handle selection
          setState(() {
            
            _selectedMethods == 0 ? _expenceCategory = value as ExpenceCategory 
            : _incomeCategory = value  as IncomeCategory; 
          });
          },
        ),

        SizedBox(height: 20,),

        TextFormField(
          controller: _titleController ,
          decoration: InputDecoration(
            hintText: "Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
                        contentPadding: EdgeInsets.symmetric(
              vertical: kDefalutPadding, // make sure this constant exists
              horizontal: 20,)
          ),

          
        ),

        SizedBox(height: 20,),


        TextFormField(
          controller: _descriptionController ,
          decoration: InputDecoration(
            hintText: "Description",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
                        contentPadding: EdgeInsets.symmetric(
              vertical: kDefalutPadding, // make sure this constant exists
              horizontal: 20,)
          ),

          
        ),
SizedBox(height: 20,),

            TextFormField(
          controller: _amountController ,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(
            hintText: "Amount",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
                        contentPadding: EdgeInsets.symmetric(
              vertical: kDefalutPadding, // make sure this constant exists
              horizontal: 20,)
          ),

          
        ),

        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020), 
                  lastDate: DateTime(2025)).then((value){
                    if(value != null){
                      setState(() {
                        _selectedDate = value;
                      });
                    }
                  });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kMainColor,
              
              
                ),
              
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10
                ),
              
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_outlined,
                    color: kWhite,),
              
                    SizedBox(width: 10,),
              
                    Text(
                      "Select Date",
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                
              ),
            ),

            Text(DateFormat.yMMMd().format(_selectedDate),style: 
            TextStyle(color: kMainColor, 
            fontSize: 16,
            fontWeight: FontWeight.w500),)

          ],
        ),
        SizedBox(height: 15,),

        

                Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {

                showTimePicker(
                  context: context, 
                  initialTime: TimeOfDay.now()).
                  then((value){
                    if(value != null){
                      setState(() {
                        _selectedTime = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                      _selectedDate.day,
                      value.hour,
                      value.minute
                      );
                      });

                    }
                  });
              
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kYellow,
              
              
                ),
              
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10
                ),
              
                child: Row(
                  children: [
                    Icon(Icons.timer,
                    color: kWhite,),
              
                    SizedBox(width: 10,),
              
                    Text(
                      "Select Time",
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                
              ),
            ),

            Text(DateFormat.jm().format(_selectedTime),style: 
            TextStyle(color: kMainColor, 
            fontSize: 16,
            fontWeight: FontWeight.w500),)

          ],
        ),

        SizedBox(height: 20,),

        Divider(
          color: kLightGrey,
          thickness: 5,
        ),

        SizedBox(height: 20,),

        CustomButton(buttonName: "Add", 
        buttonColor: _selectedMethods == 0 ? kRed : kGreen)



        
      ],
    ),
  ),
),



        

        
                )
        
        
        
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
