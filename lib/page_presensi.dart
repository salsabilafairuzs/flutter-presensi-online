import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Presensi(),
    );
  }
}

class Presensi extends StatefulWidget {
  @override
  State<Presensi> createState() => _Presensi();
}

class _Presensi extends State<Presensi> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nim = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  // TextEditingController selectDate = DateTime.now() as TextEditingController;

  DateTime selectDate = DateTime.now();
  String _presensi = "";

  void _pilihPresensi(String value) {
    setState(() {
      _presensi = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: new Text("Presensi"),
        backgroundColor: Colors.amber,
        titleTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // ignore: unnecessary_new
      body: Form(
        key: _formKey,
        child: new ListView(
          padding: new EdgeInsets.all(16),
          children: <Widget>[
            new TextFormField(
              controller: nim,
              decoration: new InputDecoration(
                label: Text("NIM"),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "NIM harus diisi!";
                }
              },
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20),
            ),
            new TextFormField(
              controller: nama,
              decoration: new InputDecoration(
                label: Text("Nama Lengkap"),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Nama harus diisi!";
                }
              },
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectDate.toString(),
                  style: TextStyle(),
                ),
                new OutlinedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                      // selectableDayPredicate: (day) {
                      //   if ((day.isAfter(
                      //           DateTime.now().subtract(Duration(days: 1)))) &&
                      //       (day.isBefore(
                      //           DateTime.now().add(Duration(days: 0))))) {
                      //     return true;
                      //   }
                      //   return false;
                      // },
                      // builder: (context, child) {
                      //   return Theme(
                      //     data: ThemeData.dark(),
                      //     child: child,
                      //   );
                      // },
                    ).then(
                      (value) {
                        if (value != null)
                          setState(() {
                            selectDate = value;
                          });
                      },
                    );
                  },
                  child: Text("Tanggal"),
                ),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pilih :",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                ),
                new RadioListTile(
                  value: "Luring",
                  title: new Text("Luring"),
                  groupValue: _presensi,
                  onChanged: (String? value) {
                    _pilihPresensi(value!);
                  },
                  activeColor: Colors.red,
                ),
                new RadioListTile(
                  value: "Daring",
                  title: new Text("Daring"),
                  groupValue: _presensi,
                  onChanged: (String? value) {
                    _pilihPresensi(value!);
                  },
                  activeColor: Colors.red,
                ),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "nim": nim.text,
                        "nama": nama.text,
                        "tanggal": selectDate.toString(),
                        "status": _presensi,
                      };
                      FirebaseFirestore.instance
                          .collection("presensi")
                          .add(data);
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        title: 'SUBMIT BERHASIL',
                        text: 'Presensi telah tersimpan',
                        confirmBtnText: 'DONE',
                      );
                    }
                  },
                  child: Text(
                    "      S U B M I T      ",
                    style: TextStyle(color: Colors.white),
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
