import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {

static Future<void> storeUserDetails({
  required BuildContext context, 
  required String userName, 
  required String email, 
  required String password, 
  required String confirmPassword
}) async {


  try {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password and Confirm password do not match")),
      );
      return; // Exit the function if passwords don't match
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("userName", userName);
    await prefs.setString("email", email);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("User registered successfully")),
    );

  } catch (err) {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred: ${err.toString()}")),
    );
  }
}

static Future <bool> checkUsername() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userName = prefs.getString('username');
  return userName != null;
}



}
