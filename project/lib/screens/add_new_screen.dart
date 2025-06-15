import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';
import 'package:project/model/expens_model.dart';
import 'package:project/model/income_model.dart';
import 'package:project/services/expense_service.dart';
import 'package:project/services/income_service.dart';
import 'package:project/widgets/custom_button.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpense;
  final Function(Income) addIncome;
  const AddNewScreen({
    super.key,
    required this.addExpense,
    required this.addIncome,
  });

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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 10,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 10,
                            ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefalutPadding,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How Much?",
                          style: TextStyle(
                            color: kLightGrey.withOpacity(0.8),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        TextField(
                          style: TextStyle(
                            fontSize: 60,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),

                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(
                              color: kWhite,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                      topRight: Radius.circular(20),
                    ),
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
                                vertical: kDefalutPadding,
                                horizontal: 20,
                              ),
                            ),
                            items:
                                _selectedMethods == 0
                                    ? ExpenceCategory.values.map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList()
                                    : IncomeCategory.values.map((category) {
                                      // Fixed: Use IncomeCategory instead of ExpenceCategory
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList(),

                            value:
                                _selectedMethods == 0
                                    ? _expenceCategory
                                    : _incomeCategory,
                            onChanged: (value) {
                              setState(() {
                                if (_selectedMethods == 0) {
                                  _expenceCategory = value as ExpenceCategory;
                                } else {
                                  _incomeCategory = value as IncomeCategory;
                                }
                              });
                            },
                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    kDefalutPadding, // make sure this constant exists
                                horizontal: 20,
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    kDefalutPadding, // make sure this constant exists
                                horizontal: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    kDefalutPadding, // make sure this constant exists
                                horizontal: 20,
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Date Picker Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                        context: context,
                                        initialDate: _selectedDate,
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(
                                          2030,
                                        ), // Extended range
                                      );

                                  if (pickedDate != null &&
                                      pickedDate != _selectedDate) {
                                    setState(() {
                                      _selectedDate = pickedDate;
                                      // Update time to maintain the same time but with new date
                                      _selectedTime = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        _selectedTime.hour,
                                        _selectedTime.minute,
                                      );
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kMainColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: kWhite,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15),

                          // Time Picker Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                          _selectedTime,
                                        ),
                                      );

                                  if (pickedTime != null) {
                                    setState(() {
                                      _selectedTime = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kYellow,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer, color: kWhite),
                                      SizedBox(width: 10),
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),

                          Divider(color: kLightGrey, thickness: 5),

                          SizedBox(height: 20),

                          GestureDetector(
                            onTap: () async {
                              //save the expense or the income data into shared pref
                              if (_selectedMethods == 0) {
                                List<Expense> loadedExpenses =
                                    await ExpenseService().loadExpenses();

                                Expense expense = Expense(
                                  id: loadedExpenses.length + 1,
                                  title: _titleController.text,
                                  amount:
                                      _amountController.text.isEmpty
                                          ? 0
                                          : double.parse(
                                            _amountController.text,
                                          ),
                                  category: _expenceCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );

                                //add expense
                                widget.addExpense(expense);

                                //clear the fields
                                _titleController.clear();
                                _amountController.clear();
                                _descriptionController.clear();
                              } else {
                                //Load incomes
                                List<Income> loadedIncomes =
                                    await IncomeService().loadIncomes();
                                //crreate the new income

                                Income income = Income(
                                  id: loadedIncomes.length + 1,
                                  title: _titleController.text,
                                  amount:
                                      _amountController.text.isEmpty
                                          ? 0
                                          : double.parse(
                                            _amountController.text,
                                          ),
                                  category: _incomeCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );

                                widget.addIncome(income);

                                //clear the fields
                                _titleController.clear();
                                _amountController.clear();
                                _descriptionController.clear();
                              }
                            },
                            child: CustomButton(
                              buttonName: "Add",
                              buttonColor:
                                  _selectedMethods == 0 ? kRed : kGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
