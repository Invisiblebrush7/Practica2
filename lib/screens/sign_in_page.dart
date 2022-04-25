import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/googleauth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.dstATop),
              image: AssetImage("images/background.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign In",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Image(
                height: MediaQuery.of(context).size.height / 5,
                color: Colors.white,
                image: AssetImage(
                  'images/music.png',
                ),
              ),
              Container(),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<GoogleAuthBloc>(context)
                      .add(NewGoogleAuthEvent());
                },
                child: Text("Iniciar con Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
