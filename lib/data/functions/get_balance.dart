import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<double> fetchBalance() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String walletAddress = prefs.getString('walletAddress') ?? '';
  String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse(
        //'https://api.socialverseapp.com/solana/wallet/balance?network=devnet&wallet_address=$walletAddress'
        'https://api.socialverseapp.com/solana/wallet/balance?network=devnet&wallet_address=9vua72VP11ez8JwgPvWD4nPkjBpRsJWmnaTsdyx8h3df'
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Flic-Token': token,
    },
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    Map<String, dynamic> json = jsonDecode(response.body);
    return double.parse(json['balance'].toString());
  } else {
    // If the server did not return a 200 OK response, then return -1.
    return -1;
  }
}