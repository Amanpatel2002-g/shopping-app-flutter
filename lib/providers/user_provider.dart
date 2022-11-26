
import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  AuthServices authServices = AuthServices();

  UserModel _user = UserModel(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '');
  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }
}
