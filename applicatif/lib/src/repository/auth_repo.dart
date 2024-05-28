import 'dart:convert';

import 'package:applicatif/src/data_provider/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  login(String username, String password) async {
    int role = 0;
    final url = Uri.parse("${baseApiUrl}login");
    if(username == 'admin1' ) {
       role = 1;
    }
    final body = {
      "userName": username,
      "password": password,
      "role" : role
    };
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final response = await http.post(url, headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      const data = "auth problem"; 
      return data;
    }
  }

    Future<String> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? isLoggedIn = prefs.getString('role');
    String isLog = isLoggedIn.toString();
    if (isLog == 'User' || isLog == 'Admin') {
    return isLog;
  } else {}
    return '';
    }
}
