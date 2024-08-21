import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://restcountries.com/v3.1/region/europe";

  Future<List<Country>> getCountries() async {
    try {
      final response = await http.get(Uri.parse(
          baseUrl + "?fields=name,capital,flags,region,languages,population"));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }
}

class Country {
  final Map<String, dynamic> flags;
  final Map<String, dynamic> name;
  final List<String> capital;
  final String region;
  final Map<String, String> languages;
  final int population;

  Country({
    required this.flags,
    required this.name,
    required this.capital,
    required this.region,
    required this.languages,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      flags: json['flags'],
      name: json['name'],
      capital: List<String>.from(json['capital']),
      region: json['region'],
      languages: Map<String, String>.from(json['languages']),
      population: json['population'],
    );
  }
}
