import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool>sendFunds(double amount, String recieverAddress,String pin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('https://api.socialverseapp.com/solana/wallet/transfer'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Flic-Token': token,
    },
    body: jsonEncode(<String, dynamic>{
      'recipient_address': recieverAddress,
      'network': 'devnet',
      'sender_address': recieverAddress,
      'amount': amount,
      'user_pin': pin,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, return true.
    return true;
  } else {
    // If the server did not return a 200 OK response, then return false.
    return false;
  }
}

Future<bool> requestFunds(double amount,String senderAddress) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('https://api.socialverseapp.com/solana/wallet/airdrop'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Flic-Token': token,
    },
    body: jsonEncode(<String, dynamic>{
      'wallet_address': senderAddress,
      'network': 'devnet',
      'amount': amount,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, return true.
    return true;
  } else {
    // If the server did not return a 200 OK response, then return false.
    return false;
  }
}


Future<bool> createWallet(String walletName, String pin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('https://api.socialverseapp.com/solana/wallet/create'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Flic-Token': token,
    },
    body: jsonEncode(<String, dynamic>{
      'wallet_name': walletName,
      'network': 'devnet',
      'user_pin': pin,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the response.
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    String publicKey = responseBody['publicKey'];

    // Store the public address in the shared preferences.
    await prefs.setString('walletAddress', publicKey);
    return true;
  } else {
    return false;
  }
}