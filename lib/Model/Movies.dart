
class Movies{
  String  Title;
  String  Year;
  String imdbID;
  String Type;
  String Poster;

  Movies({
    required this.Title,
    required this.Year,
    required this.imdbID,
    required this.Type,
    required this.Poster,
  });

  factory Movies.fromJson(Map<String,dynamic> json) {
    return Movies(
      Title: json['Title'],
      Year: json['Year'] ,
      imdbID: json['imdbID'],
      Type: json['Type'],
      Poster: json['Poster'],
    );
  }
}