import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:practica2/screens/sign_in_page.dart';

import 'bloc/favsongs_bloc.dart';
import 'bloc/googleauth_bloc.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GoogleAuthBloc()..add(VerifyGoogleAuthEvent()),
      ),
      BlocProvider(
        create: (context) => FavsongsBloc()..add((GetAllFavsEvent())),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      themeMode: ThemeMode.dark,
      title: 'Material App',
      home: BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GoogleAuthSuccessState) {
            print("Success Auth");
            return HomePage();
          } else if (state is GoogleAuthErrorState ||
              state is GoogleAuthSignOutSuccessState) {
            print("Google auth sign out success");
            return SignInPage();
          } else if (state is GoogleAuthLoadingState) {
            print("Loading");
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            print(state);
            return Scaffold(
              body: Center(
                child: Text("Error al iniciar :("),
              ),
            );
          }
        },
      ),
    );
  }
}
