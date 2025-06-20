import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';
import 'package:project/screens/onboarding_screen.dart';
import 'package:project/services/expense_service.dart';
import 'package:project/services/income_service.dart';
import 'package:project/services/user_services.dart';
import 'package:project/widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    UserServices.getUserData().then((value) {
      if (value['username'] != null && value['email'] != null) {
        setState(() {
          username = value['username']!;
          email = value['email']!;
        });
      }
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kWhite,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(kDefalutPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Are you sure you want to log?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kGreen),
                    ),
                    onPressed: () async {
                      await UserServices.clearUserDetails();

                      if (context.mounted) {
                        await ExpenseService().deleteAllExpenses(context);
                        await IncomeService().deleteAllIncomes(context);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: Text("Yes"),
                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kRed),
                    ),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kMainColor,
                        border: Border.all(color: kMainColor, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/user.jpg",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 45),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome $username",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kBlack,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: kGrey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Add notification logic here
                      },
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kMainColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.edit, color: kMainColor, size: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                ProfileCard(
                  icon: Icons.wallet,
                  title: "My Wallet",
                  color: kMainColor,
                ),
                const ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kYellow,
                ),
                const ProfileCard(
                  icon: Icons.download,
                  title: "Export Data",
                  color: kGreen,
                ),

                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: ProfileCard(
                    icon: Icons.logout,
                    title: "Log Out",
                    color: kRed,
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
