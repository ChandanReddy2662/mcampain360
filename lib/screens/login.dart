import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:myapp/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:web/helpers.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _otp = TextEditingController();

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
        actions: [],
      ),
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
                    child: TextFormField(
                      controller: _phonenumber,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final validator = Validator(
                          validators: [
                            const RequiredValidator(),
                            const PhoneNumberValidator(),
                          ],
                        );
                        return validator.validate(
                          label: 'Email',
                          value: value,
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _otp,
                      decoration: const InputDecoration(
                        labelText: 'OTP',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        final validator = Validator(
                          validators: [
                            const RequiredValidator(),
                          ],
                        );
                        return validator.validate(
                          label: 'OTP',
                          value: value,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
