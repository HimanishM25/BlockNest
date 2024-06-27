import 'package:blocknet/presentation/new_wallet.dart';
import 'package:blocknet/presentation/authentication/signin.dart';
import 'package:blocknet/presentation/widgets/common_text_field.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2C2C2C),
      body:
         SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello There!', style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold,color: Colors.white)),
                SizedBox(height: 50.0),
                Text("Username", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                SizedBox(height: 5.0),
                CustomTextField(hintText: 'Username', controller: usernameController),
                SizedBox(height: 10.0),
                Text("Password", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                SizedBox(height: 5.0),
                CustomTextField(hintText: 'Password', isPassword: true,controller: passwordController),
                SizedBox(height: 10.0),
                Text("Confirm Password", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                SizedBox(height: 5.0),
                CustomTextField(hintText: 'Confirm Password', isPassword: true,controller: confirmPassController),
              ],
            ),
          ),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewWallet()));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    shape: WidgetStateProperty.all<CircleBorder>(
                      const CircleBorder(),
                    ),
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.black, size: 30.0),
                ),
              ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Already have an account?", style: TextStyle(fontSize: 12.0, color: Colors.white)),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                },child:const Text("Sign In", style: TextStyle(fontSize: 12.0, color: Colors.white))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
