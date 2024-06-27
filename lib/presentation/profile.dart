import 'package:blocknet/presentation/authentication/signin.dart';
import 'package:blocknet/presentation/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = '';
  String lastName = '';
  String walletAddress = '';
  String profilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  void loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      walletAddress = prefs.getString('walletAddress') ?? '';
      profilePictureUrl = prefs.getString('profilePictureUrl') ?? '';
    });
  }
  @override
  Widget build(BuildContext context) {
   // String walletAddress = '9vua72VP11ez8JwgPvWD4nPkjBpRsJWmnaTsdyx8h3df';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  profilePictureUrl.isNotEmpty
                      ? CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(profilePictureUrl),
                  )
                      : SvgPicture.asset('assets/profile.svg', width: 70, height: 70),
                  const SizedBox(width: 20.0),
                  Flexible(
                    child: Text(
                      '$firstName $lastName',
                      style: TextStyle(fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Text("Wallet Address", style: TextStyle(fontSize: 20.0, color: Colors.black,fontWeight: FontWeight.bold)),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      walletAddress,
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, size: 15.0, color: Colors.black),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: walletAddress));
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 60,
          child: CommonButton(
              leadingIcon: Icons.logout,
              buttonText: 'Logout',
              textColor: Colors.white,
              buttonColor: Color(0xff2C2C2C),
            onClick: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ),
      )
    );
  }
}
