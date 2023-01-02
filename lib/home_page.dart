import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas_1/main.dart';
import 'package:flutter_uas_1/page_presensi.dart';
import 'package:flutter/cupertino.dart';
import 'page_perizinan.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  // final user = FirebaseAuth.instance.currentUser!;
  // int lastId = 1;
  // final List<MyItem> list = [];
  Widget _userUid() {
    return Text(
      "Login sebagai : ${user?.email}",
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Home Page'),
        backgroundColor: Colors.amber,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          icon: new Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ),
      body: new Container(
        child: new ListView(
          padding: new EdgeInsets.all(20),
          children: <Widget>[
            Padding(padding: new EdgeInsets.only(top: 20)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 150,
                      ),
                      // Image.asset(
                      //   "images/logo.png",
                      //   width: 200,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _userUid(),
                Padding(padding: new EdgeInsets.only(bottom: 40)),
                Container(
                  height: 60,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Presensi(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Text(
                          "P R E S E N S I",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.only(top: 20)),
                Container(
                  height: 60,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Perizinan(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Text(
                          "P E R I Z I N A N",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
