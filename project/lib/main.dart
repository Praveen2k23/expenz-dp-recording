import 'package:flutter/material.dart';
import 'package:project/services/user_services.dart';
import 'package:project/widgets/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance(); // optional if used later
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? hasUserName;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    bool result = await UserServices.checkUsername();
    setState(() {
      hasUserName = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasUserName == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Inter"),
      home: Wrapper(showMainScreen: hasUserName!),
    );
  }
}
