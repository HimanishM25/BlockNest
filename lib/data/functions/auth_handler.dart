import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> loginUser(String username, String password) async {
  final response = await http.post(
    Uri.parse('https://api.socialverseapp.com/user/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'mixed': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    Map<String, dynamic> json = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', json['token']);
    await prefs.setString('walletAddress', json['wallet_address']);
    await prefs.setString('firstName', json['first_name']);
    await prefs.setString('lastName', json['last_name']);
    await prefs.setString('email', json['email']);
    bool hasWallet = json['has_wallet'];
    await prefs.setBool('hasWallet', hasWallet);
    await prefs.setString('profilePictureUrl', json['profile_picture_url']);
    await prefs.setBool('isLoggedIn', true);
    return hasWallet ? 1 : 2;
  } else {
    return 3;
  }
}