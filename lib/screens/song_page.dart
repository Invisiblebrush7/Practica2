import 'package:flutter/material.dart';

import '../components/big_card.dart';

class SongPage extends StatelessWidget {
  final String author;
  final String title;
  final String imageUrl;

  SongPage({required this.author, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              print("Quitar de fav");
            },
          ),
        ],
        title: Text(this.title),
      ),
      body: Center(
        child: BigCard(author: author, title: title, imageUrl: imageUrl),
      ),
    );
  }
}
