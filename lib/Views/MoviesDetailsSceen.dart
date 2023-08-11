import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Utils/apptextsytle.dart';

class MovieDetailScreen extends StatelessWidget {
  final String imdbID;

  MovieDetailScreen({required this.imdbID});

  Future<Map<String, dynamic>> fetchMovieDetails() async {
    final apiKey = '39a36280';
    final url = 'https://www.omdbapi.com/?apikey=$apiKey&i=$imdbID';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchMovieDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading movie details.'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(movie['Poster']),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        movie['Title'],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text('Year: ${movie['Year']}',style: GoogleFonts.openSans(
                          textStyle:year
                      )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text('Genre: ${movie['Genre']}',style: GoogleFonts.openSans(
                          textStyle:Genre
                      )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text('Plot:  ${movie['Plot']}',style: GoogleFonts.openSans(
                          textStyle:plot
                      )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text('Language: ${movie['Language']}',style: GoogleFonts.openSans(
                        textStyle:language
                      ),),
                    ),
                    // You can add more details as needed
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
