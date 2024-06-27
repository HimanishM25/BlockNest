import 'package:blocknet/presentation/request/request_money.dart';
import 'package:blocknet/presentation/send/send_money.dart';
import 'package:blocknet/presentation/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/functions/get_balance.dart';

class HomeScreen extends StatefulWidget {
  final String walletName;
  const HomeScreen({super.key, required this.walletName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0.0;

  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    super.initState();
    loadProfileData();
    fetchBalance().then((value) {
      setState(() {
        balance = value;
      });
    });
  }
  void loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
    });
  }

  void refreshBalance() {
    fetchBalance().then((value) {
      setState(() {
        balance = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child:
                  Text('${firstName}\'s Wallet',
                    style: const TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                width: double.infinity,
                height: 150.0,
                child: Card(
                  elevation: 0,
                  color: Color(0xff2C2C2C),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Wallet Balance',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                            IconButton(
                              icon: Icon(Icons.refresh, color: Colors.white),
                              onPressed: fetchBalance,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text("\$ ${balance.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: CommonButton(
                        trailingIcon: LineIcons.paperPlane,
                        buttonText: 'Send',
                        textColor: Colors.white,
                        buttonColor: Color(0xffFFA500),
                        onClick: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SendMoney(currentBalance: balance,)));
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: CommonButton(
                        trailingIcon: LineIcons.wallet,
                        buttonText: 'Request',
                        textColor: Colors.white,
                        buttonColor: Color(0xff2196F3),
                        onClick: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RequestMoney()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
