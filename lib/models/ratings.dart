import 'dart:convert';
import 'dart:ffi';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Ratings {
  final double ratings;
  final String userId;
  Ratings({
    required this.ratings,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ratings': ratings,
      'userId': userId,
    };
  }

  int x = 4;

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      ratings: map['ratings'].toDouble(),
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratings.fromJson(String source) =>
      Ratings.fromMap(json.decode(source) as Map<String, dynamic>);
}
