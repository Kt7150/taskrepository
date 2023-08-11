import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Model/Movies.dart';
import '../Utils/apptextsytle.dart';
import 'MoviesDetailsSceen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Movies> _movies = [];

  Future<void> _fetchMovies() async {

    final url = 'https://www.omdbapi.com/?apikey=39a36280&s=iron%20man';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Search'] != null) {
        setState(() {
          _movies = List<Movies>.from(data['Search'].map((m) => Movies.fromJson(m)));
          print(_movies);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App',style: GoogleFonts.roboto(
          textStyle: apptext
        ),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                _fetchMovies();
              },
              child: Text("Call Api"),
            )
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    print("object");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          MovieDetailScreen(imdbID: _movies[index].imdbID)),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          height: height*0.4,
                          margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                          child: Image(image: NetworkImage(
                            _movies[index].Poster,
                          )),
                        ),
                        Center(
                          child: Text(_movies[index].Title,style: GoogleFonts.roboto(
                            textStyle: title
                          ),
                          ),
                        ),
                        Center(
                          child: Text(_movies[index].Year,style: GoogleFonts.roboto(
                              textStyle: title
                          ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


