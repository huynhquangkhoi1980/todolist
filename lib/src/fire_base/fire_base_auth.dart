import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      // case create successful
      _createUser(result.user!.uid, name, phone, onSuccess);
      // ignore: avoid_print
      print(result);
    }).catchError((onError) {
      // TODO
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess) {
    var user = {"name": name, "phone": phone};

    var ref = FirebaseDatabase.instance.reference().child("user");
    ref.child(userId).set(user).then((user) {
      // create succesfull case
      onSuccess();
    }).catchError((err) {
      // TODO
    });
  }
}
