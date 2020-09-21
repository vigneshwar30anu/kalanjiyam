import 'package:flutter/material.dart';
import 'package:kalanjiyam/pages/login_signup/Login.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsetsDirectional.fromSTEB(30, 5, 0, 0),
                  title: ListTile(
                    title: Text('Settings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                  ),
                  background: Image.asset(
                    "assets/images/settings.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 42,
                    ),
                    Text(
                      'Login/SignUp',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
