import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {

  static Future<void> storeUserDetails({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password and Confirm password do not match")),
        );
        return; // Exit if passwords don't match
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("userName", userName); // Consistent key
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

  static Future<bool> checkUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName'); // Fixed key
    return userName != null;
  }

  static Future<Map<String, String>> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? userName = pref.getString("userName"); // Fixed key
    String? email = pref.getString("email");

    return {
      "username": userName ?? "", // Safe fallback
      "email": email ?? "",
    };
  }
}
