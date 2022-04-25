import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String author;
  final String title;
  final String imageUrl;

  Song({required this.author, required this.title, required this.imageUrl});

  Song.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          author: json['author']! as String,
          imageUrl: json['imageUrl']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
    };
  }
}

final songsCollection =
    FirebaseFirestore.instance.collection('favs').withConverter<Song>(
          fromFirestore: (snapshot, _) => Song.fromJson(snapshot.data()!),
          toFirestore: (song, _) => song.toJson(),
        );
