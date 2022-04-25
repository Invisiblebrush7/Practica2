import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/screens/song_page.dart';

import '../bloc/favsongs_bloc.dart';

class SmallCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;

  SmallCard({
    required this.author,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo[700],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongPage(
                        author: author,
                        title: title,
                        imageUrl: imageUrl,
                      ),
                    ),
                  );
                },
                child: Image(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    this.imageUrl,
                    // scale: 4.0,
                  ),
                ),
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    BlocProvider.of<FavsongsBloc>(context)
                        .add(RemoveFavEvent(title: this.title));
                  },
                ),
                top: 10.0,
                left: 10.0,
              ),
            ],
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
        ],
      ),
    );
  }
}
