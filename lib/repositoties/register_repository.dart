import 'package:flutter_login/services/api_services.dart';

class RegisterRepository {
  final ApiService api = ApiService();
  Future<int> register(String email, String username, String password) async {
    int kq = 2;
    final response = await api.registerUser(
      email,
      username,
      password,
    );
    if (response != null && response.statusCode == 201) {
      if (response.data['requires_email_confirmation'] == true) {
        return kq = 3;
      } else {
        return kq = 4;
      }
    }
    return kq;
  }
}
