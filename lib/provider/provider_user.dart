
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/handle/auth_methods.dart';
import 'package:instagram_clone/model/user.dart';

class ProviderUser extends ChangeNotifier{
  User? _user;
  User get getUser => _user!;
  AuthMethods authMethods = AuthMethods();

  Future<void> refestUser() async{
    User user = await authMethods.getUserInfo();
    _user = user;
    notifyListeners();
  }
}