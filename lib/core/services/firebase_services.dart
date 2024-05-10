import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_table/features/models/restaurant_model.dart';

class FirebaseServices {
  static late FirebaseAuth _auth;
  static late FirebaseFirestore _db;
  static late FirebaseStorage _storage;

  static late User? user;

  static init() {
    _auth = FirebaseAuth.instance;
    _db = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instanceFor(
        bucket: 'gs://open-table-27826.appspot.com');
  }

  static logout() {
    _auth.signOut();
  }

  static User getUser() {
    return _auth.currentUser!;
  }

  static addToFav({
    required RestuarentModel model,
    required User user,
  }) async {
    await FirebaseFirestore.instance
        .collection('favourite-list')
        .doc(user.uid)
        .set({
      model.id ?? '': model.toJson(),
    }, SetOptions(merge: true));
  }

  static deleteItemFromFav(hotelId) {
    FirebaseFirestore.instance.collection('favourite-list').doc(user?.uid).set({
      hotelId: FieldValue.delete(),
    }, SetOptions(merge: true));
  }
}
