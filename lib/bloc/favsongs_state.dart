part of 'favsongs_bloc.dart';

abstract class FavsongsState extends Equatable {
  const FavsongsState();

  @override
  List<Object> get props => [];
}

class FavsongsInitial extends FavsongsState {}

class FavSongsSuccessState extends FavsongsState {
  final List<Map<String, dynamic>> favSongs;

  FavSongsSuccessState({required this.favSongs});

  @override
  List<Object> get props => [this.favSongs];
}

class FavSongsErrorState extends FavsongsState {}

class FavSongsEmptyState extends FavsongsState {}

class FavSongsLoadingState extends FavsongsState {}
