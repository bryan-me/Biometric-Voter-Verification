// import 'package:biometric_login/success_screen.dart';
//import 'package:fingerprint_verification/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/success_page.dart';
import 'package:flutter_application_1/services/authservice.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
          //const  Icon(Icons.lock,size:80),
          const SizedBox(height: 20,),
          const Text("Click button to verify voter fingerprint"),
          const SizedBox(height: 20,),
            InkWell(
              onTap: () async {
                bool isAuthenticated = await AuthService.authenticateUser();

                if (isAuthenticated) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const SuccessPage()),
                      );
                 
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Authentication failed.'),
                    ),
                  );
                }
              },
              child: Center(
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2.5)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fingerprint,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          "Verify Voter",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}