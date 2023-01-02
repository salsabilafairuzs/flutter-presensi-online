import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseServices {
  static Future<String> uploadImage(File image) async {
    String fileName = basename(image.path);

    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = ref.putFile(image);
    TaskSnapshot snapshot = await task;

    return await snapshot.ref.getDownloadURL();
  }
}
