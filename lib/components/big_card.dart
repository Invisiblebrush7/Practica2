import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;

  BigCard({required this.author, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image(
            height: MediaQuery.of(context).size.height / 2 + 100,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            image: NetworkImage(
              this.imageUrl,
              scale: 4.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              this.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              this.author,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                    image: AssetImage('images/spotify.png'),
                    height: 40.0,
                    color: Colors.grey[200]),
                SizedBox(width: 30.0),
                Image(
                    image: AssetImage('images/share.png'),
                    height: 40.0,
                    color: Colors.grey[200]),
                SizedBox(width: 30.0),
                Image(
                    image: AssetImage('images/apple.png'),
                    height: 40.0,
                    color: Colors.grey[200]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
