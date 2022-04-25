import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practica2/utils/auth_repo.dart';

part 'favsongs_event.dart';
part 'favsongs_state.dart';

class FavsongsBloc extends Bloc<FavsongsEvent, FavsongsState> {
  FavsongsBloc() : super(FavsongsInitial()) {
    on<GetAllFavsEvent>(GetAllFavs);
    on<RemoveFavEvent>(RemoveFav);
  }

  FutureOr<void> GetAllFavs(event, emit) async {
    emit(FavSongsLoadingState());
    try {
      // Query to get pictures from current user
      var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");
      // get data from document
      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["favsList"] ?? [];
      // query to get documents from fshare
      var queryPictures =
          await FirebaseFirestore.instance.collection("favs").get();

      // filter everything (that it belongs to current user and is not published)
      var favSongsList = await queryPictures.docs
          .where((doc) => listIds.contains(doc.id))
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();
      if (favSongsList.isEmpty) {
        emit(FavSongsEmptyState());
      } else {
        emit(FavSongsSuccessState(favSongs: favSongsList));
      }
    } catch (e) {
      print("Error while getting disabled items: ${e}");
    }
  }

  FutureOr<void> RemoveFav(event, emit) async {
    emit(FavSongsLoadingState());
    try {
      // Query to get pictures from current user
      var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");
      // get data from document
      var docsRef = await queryUser.get();
      List<dynamic> songsIDs = docsRef.data()?["favsList"] ?? [];
      // query to get documents from favs
      var queryPictures =
          await FirebaseFirestore.instance.collection("favs").get();

      // filter everything (that it belongs to current user and is not published)

      var listOfIDs = await queryPictures.docs.where(
          (doc) => doc["title"] != event.title && songsIDs.contains(doc.id));

      var favSongsList = await listOfIDs
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();

      List<String> newFavsIDS = [];

      for (var doc in listOfIDs) {
        newFavsIDS.add(doc.id);
      }

      if (favSongsList.isEmpty) {
        emit(FavSongsEmptyState());
      } else {
        RequestsRepo repo = RequestsRepo();
        repo.createUserCollectionFromCopy(
            FirebaseAuth.instance.currentUser!.uid, newFavsIDS);
        emit(FavSongsSuccessState(favSongs: favSongsList));
      }
    } catch (e) {
      print("Error while getting items: ${e}");
    }
  }
}
