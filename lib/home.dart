import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_github_authentication/services/auth_service.dart';
import 'package:flutter/material.dart';

final AuthService authService = AuthService();

class Home extends StatefulWidget {
  final User user;

  Home({@required this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loader;

  @override
  void initState() {
    loader = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body:  Container(
          height: height,
          width: width,
          child: loader
          ? Center(
            child: CircularProgressIndicator(),
          )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hey ' + widget.user.displayName +"!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              ),
              SizedBox(height: height*0.03,),
              Container(
                height: height*0.26,
                width: height*0.26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5,
                    color: Colors.white
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.user.photoURL
                    )
                  )
                ),
              ),
              SizedBox(height: height*0.03,),
              Text(
                'User ID: ' + widget.user.uid,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
              Text(
                'Email: ' + widget.user.email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
              SizedBox(height: height*0.03,),
              Container(
                height: height*0.06,
                width: width*0.47,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  color: const Color(0xff2ea44f),
                  onPressed: (){
                    setState(() {
                      loader = true;
                    });
                    authService.signOutWithGitHub();
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}