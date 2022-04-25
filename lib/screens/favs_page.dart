import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/components/small_card.dart';

import '../bloc/favsongs_bloc.dart';

class FavsPage extends StatefulWidget {
  const FavsPage({Key? key}) : super(key: key);

  @override
  State<FavsPage> createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("Favoritos"),
      ),
      body: BlocConsumer<FavsongsBloc, FavsongsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavSongsSuccessState) {
            return ListView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: state.favSongs.length,
              itemBuilder: (BuildContext context, int index) {
                return SmallCard(
                  author: state.favSongs[index]["author"],
                  title: state.favSongs[index]["title"],
                  imageUrl: state.favSongs[index]["imageUrl"],
                );
              },
            );
          } else if (state is FavSongsEmptyState) {
            return Center(
              child: Text("Sin favoritos"),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
