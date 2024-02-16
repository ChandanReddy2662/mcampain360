import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _uname = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(173, 216, 230, 1),
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(250, 185, 185, 1),
          title: Text(
            "Aridnik Share",
            style: GoogleFonts.robotoSlab(
                fontSize: 40, color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          centerTitle: true,
          actions: []),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _uname,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _pass,
                        decoration: const InputDecoration(
                          labelText: 'OTP',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      },
                      child: const Text("Login")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}