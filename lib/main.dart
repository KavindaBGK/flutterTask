import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'country_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
      ],
      child: MaterialApp(
        title: 'European Countries',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CountryListScreen(),
      ),
    );
  }
}
