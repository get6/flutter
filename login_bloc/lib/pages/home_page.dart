import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authentication/authentication.dart';
import '../models/models.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome, ${user.name}',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              FlatButton(
                onPressed: () {
                  authBloc.add(UserLoggedOut());
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
