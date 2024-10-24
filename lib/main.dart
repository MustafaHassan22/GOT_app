import 'package:breaking_bad/app_rotuer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BreakingBadApp(
    appRotuer: AppRotuer(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({super.key, required this.appRotuer});
  final AppRotuer appRotuer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRotuer.generateRoute,
    );
  }
}
