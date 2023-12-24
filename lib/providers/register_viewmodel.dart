import 'package:flutter/material.dart';
import 'package:flutter_login/repositoties/register_repository.dart';

class RegisterViewModel with ChangeNotifier {
  String errorMessage = '';
  int status = 0;
  // ignore: unused_field
  bool _isChecked = false;
  String errorChecked = '';
  // ignore: non_constant_identifier_names
  void SetChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  String dieukhoan =
      "There are some terms and conditions:\n 1.You haven't deployed any applications yet.\n 2.You might have deployed an empty directory.\n 3.This is a custom domain, but we haven't finished setting it up yet.";
  RegisterRepository registerrepository = RegisterRepository();
  Future<void> register(
      String email, String username, String password, String repassword) async {
    status = 1;
    notifyListeners();
    if (_isChecked == false) {
      errorChecked = "You haven't accepted the terms and conditions yet.";
      status = 2;
    } else {
      status = await registerrepository.register(email, username, password);
      if (status == 2) {
        errorChecked = "The user already exists!";
      }
    }

    notifyListeners();
  }
}
