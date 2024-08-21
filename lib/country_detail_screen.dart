import 'package:flutter/material.dart';
import '../api_service.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  CountryDetailScreen({required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name['common']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flags['png']),
            SizedBox(height: 8.0),
            Text('Official Name: ${country.name['official']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(
                'Capital: ${country.capital.isNotEmpty ? country.capital[0] : 'N/A'}'),
            SizedBox(height: 8.0),
            Text('Population: ${country.population}'),
            SizedBox(height: 8.0),
            Text('Languages: ${country.languages.values.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
