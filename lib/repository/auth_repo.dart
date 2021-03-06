import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  login(String email, String password) async {
    var res = await http.post("https://bi-app.info/wp-json/jwt-auth/v1/token",
        headers: {}, body: {"email": email, "password": password});
    final data = json.decode(res.body);

    if (data['message'] == "Credential is valid" ||
        data['message' == "Credential is valid"]) {
      return data;
    } else {
      return "auth problem";
    }
  }
}
