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
      home: Perizinan(),
    );
  }
}

class Perizinan extends StatefulWidget {
  @override
  State<Perizinan> createState() => _Perizinan();
}

class _Perizinan extends State<Perizinan> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nim = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  // TextEditingController selectDate = DateTime.now() as TextEditingController;

  DateTime selectDate = DateTime.now();
  String _perizinan = "";

  void _pilihPerizinan(String value) {
    setState(() {
      _perizinan = value;
    });
  }

  File? image;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.camera);
    image = File(imagePicked!.path);
    setState(() {});
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
        title: new Text("Perizinan"),
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
                  value: "Izin",
                  title: new Text("Izin"),
                  groupValue: _perizinan,
                  onChanged: (String? value) {
                    _pilihPerizinan(value!);
                  },
                  activeColor: Colors.red,
                ),
                new RadioListTile(
                  value: "Sakit",
                  title: new Text("Sakit"),
                  groupValue: _perizinan,
                  onChanged: (String? value) {
                    _pilihPerizinan(value!);
                  },
                  activeColor: Colors.red,
                ),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                image != null
                    ? Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 100,
                            ),
                          ],
                        ),
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                Padding(padding: new EdgeInsets.only(top: 5)),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () async {
                    await getImage();
                  },
                  child: Text(
                    "Upload Bukti",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
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
                        "status": _perizinan,
                      };
                      FirebaseFirestore.instance
                          .collection("perizinan")
                          .add(data);
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        title: 'SUBMIT BERHASIL',
                        text: 'Perizinan telah tersimpan',
                        confirmBtnText: 'DONE',
                      );
                      image =
                          (await DatabaseServices.uploadImage(image!)) as File?;
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
