import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/model/user.dart' as model;
class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<model.User> getUserInfo() async{
    DocumentSnapshot snap = await _fireStore.collection('users').doc(_auth.currentUser!.uid).get();
    var snapShot = snap.data() as Map<String, dynamic>;
    return model.User.fromSnap(snap);
  }

  Future<String> userResgister({
    required String email,
    required String password,
    required String username,
    required String address,
  }) async {
    String res = "something error";
    try {
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || address.isNotEmpty){
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );

        model.User user = model.User(
            email: email,
            uid: userCredential.user!.uid,
            password: password,
            username: username,
            address: address,
            followers: [],
            following: [],
        );

        await _fireStore.collection('users').doc(userCredential.user!.uid).set(user.toJson());
        res = "success";
      }
      }on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          res = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          res = 'The account already exists for that email.';
        }
        else{
          res = e.toString();
        }
    }catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> userLogin({
    required String email,
    required String password,
  }) async{
    String res = 'something error';
    try {
      if(email.isNotEmpty || password.isNotEmpty){
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        );
        res = 'success';
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res= 'Wrong password provided for that user.';
      }
      else{
        res = e.toString();
      }
    }
    return res;
  }

}