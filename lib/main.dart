import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blue_bloc.dart';
import 'home_page.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => BlueBloc()..add(StartScanningEvent()),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
