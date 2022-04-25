import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/auth_repo.dart';

part 'googleauth_event.dart';
part 'googleauth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  RequestsRepo authRepo = RequestsRepo();
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<VerifyGoogleAuthEvent>(verifySignIn);
    on<NewGoogleAuthEvent>(googleSignIn);
    on<SignOutGoogleAuthEvent>(signOut);
  }

  FutureOr<void> verifySignIn(event, emit) {
    if (authRepo.isSignedIn()) {
      emit(GoogleAuthSuccessState());
    } else {
      emit(GoogleAuthErrorState(error: ""));
    }
  }

  FutureOr<void> googleSignIn(event, emit) async {
    emit(GoogleAuthLoadingState());
    try {
      await authRepo.signInWithGoogle();
      emit(GoogleAuthSuccessState());
    } catch (e) {
      emit(GoogleAuthErrorState(error: "${e}"));
    }
  }

  FutureOr<void> signOut(event, emit) async {
    try {
      await authRepo.signOutGoogleUser();
      emit(GoogleAuthSignOutSuccessState());
    } catch (e) {
      emit(GoogleAuthErrorState(error: "${e}"));
    }
  }
}
