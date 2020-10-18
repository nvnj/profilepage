import 'package:flutter/material.dart';
import 'package:profile_page/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(create: (context) => MyModel(),
      child: ProfileView(),),
    );
  }
}


