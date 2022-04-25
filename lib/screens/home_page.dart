import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ripple/flutter_ripple.dart';
import 'package:practica2/screens/favs_page.dart';

import '../bloc/googleauth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ///Show Ripple Widget
            FlutterRipple(
              child: CircleAvatar(
                minRadius: 30.0,
                maxRadius: 100.0,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1619983081563-430f63602796?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
                  scale: 10.0,
                ),
              ),
              rippleColor: Colors.purple,
              onTap: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text("Escuchando...")));
              },
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 + 120,
              right: 50,
              left: 50,
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "Toque para escuchar",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavsPage()),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.login),
                          onPressed: () {
                            BlocProvider.of<GoogleAuthBloc>(context)
                                .add(SignOutGoogleAuthEvent());
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
