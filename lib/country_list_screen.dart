import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api_service.dart';
import 'country_detail_screen.dart';

class CountryListScreen extends StatefulWidget {
  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late Future<List<Country>> _futureCountries;
  String _sortBy = 'name';

  @override
  void initState() {
    super.initState();
    _futureCountries =
        Provider.of<ApiService>(context, listen: false).getCountries();
  }

  List<Country> _sortCountries(List<Country> countries) {
    List<Country> sortedCountries = List.from(countries);
    if (_sortBy == 'name') {
      sortedCountries
          .sort((a, b) => a.name['common'].compareTo(b.name['common']));
    } else if (_sortBy == 'population') {
      sortedCountries.sort((a, b) => a.population.compareTo(b.population));
    } else if (_sortBy == 'capital') {
      sortedCountries.sort((a, b) => a.capital[0].compareTo(b.capital[0]));
    }
    return sortedCountries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('European Countries'),
        actions: [
          DropdownButton<String>(
            value: _sortBy,
            items: [
              DropdownMenuItem(value: 'name', child: Text('Sort by Name')),
              DropdownMenuItem(
                  value: 'population', child: Text('Sort by Population')),
              DropdownMenuItem(
                  value: 'capital', child: Text('Sort by Capital')),
            ],
            onChanged: (value) {
              setState(() {
                _sortBy = value!;
                // Refresh the list with sorting
                _futureCountries =
                    Provider.of<ApiService>(context, listen: false)
                        .getCountries();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Country>>(
        future: _futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No countries found.'));
          }

          List<Country> countries = snapshot.data!;
          List<Country> sortedCountries = _sortCountries(countries);

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: sortedCountries.length,
            itemBuilder: (context, index) {
              final country = sortedCountries[index];
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      country.flags['png'],
                      width: 60,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    country.name['common'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    country.capital.isNotEmpty
                        ? country.capital[0]
                        : 'No Capital',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CountryDetailScreen(country: country),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
