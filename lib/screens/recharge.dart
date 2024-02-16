import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class RechargePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(173, 216, 230, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 185, 185, 1),
        title: Text(
          '₹ Recharge ',
          style: GoogleFonts.robotoSlab(
              fontSize: 25, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            // Balance Card
            Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Current Balance:',
                      style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '100.00 ₹', // Replace with the actual balance from your data
                      style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Payment Options
            Text(
              'Select Payment Method:',
              style: GoogleFonts.robotoSlab(
                  fontSize: 25, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 50),
            // Example: Payment Option Buttons with Images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PaymentOptionButton(
                  image: 'lib/assets/img1.png',
                  label: 'Credit Card',
                  paymentUrl: 'https://creditcardpaymenturl.com',
                ),
                PaymentOptionButton(
                  image: 'lib/assets/img2.png',
                  label: 'Debit Card',
                  paymentUrl: 'https://creditcardpaymenturl.com',
                ),
                PaymentOptionButton(
                  image: 'lib/assets/img4.png',
                  label: 'Paytm',
                  paymentUrl: 'https://creditcardpaymenturl.com',
                ),
              ],
            ),
            SizedBox(height: 40), // Adjust the height for spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PaymentOptionButton(
                  image: 'lib/assets/img3.png',
                  label: 'Google Pay',
                  paymentUrl: 'https://creditcardpaymenturl.com',
                ),
                PaymentOptionButton(
                  image: 'lib/assets/img5.jpg',
                  label: 'PhonePe',
                  paymentUrl: 'https://creditcardpaymenturl.com',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionButton extends StatelessWidget {
  final String image;
  final String label;
  final String paymentUrl; // Add a payment URL for each method

  const PaymentOptionButton({
    required this.image,
    required this.label,
    required this.paymentUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            launchPaymentUrl(paymentUrl);
          },
          child: Image.asset(image,
              width: 40, height: 40), // Replace with your image assets
        ),
        SizedBox(height: 10),
        Text(label),
      ],
    );
  }
}

void launchPaymentUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}