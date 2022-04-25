part of 'favsongs_bloc.dart';

abstract class FavsongsEvent extends Equatable {
  const FavsongsEvent();

  @override
  List<Object> get props => [];
}

class GetAllFavsEvent extends FavsongsEvent {}

class RemoveFavEvent extends FavsongsEvent {
  final String title;

  RemoveFavEvent({required this.title});

  @override
  List<Object> get props => [this.title];
}
