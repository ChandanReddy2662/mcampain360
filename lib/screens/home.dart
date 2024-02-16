import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/recharge.dart';
import 'dart:convert';
// import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List mapRes = [];

  Future<void> apicall() async {
    http.Response response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapRes = json.decode(response.body)['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  Future<void> shareWA(card) async {
    // Uri whatsappUrl =
    //     Uri.parse('https://wa.me/?og:image=${Uri.encodeFull("hi")}');

    // if (await canLaunch(whatsappUrl.toString())) {
    //   await launch(whatsappUrl.toString());
    // } else {
    //   print('Could not launch $whatsappUrl');
    // }
    // Share.share('Check out this image: ${mapRes[card]['avatar']}');
    String whatsappUrl =
        "whatsapp://send?text=${Uri.encodeFull(mapRes[card]['avatar'])}";
    launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> shareFB(card) async {
    // final response = await http.post(
    //   Uri.parse('https://graph.facebook.com/v15.0/me/feed/'),
    //   body: {
    //     'message': 'message',
    //     'access_token': 'your_access_token_here',
    //   },
    // );
    // if (response.statusCode == 200) {
    //   print('Post successful');
    // } else {
    //   print('Post failed with status ${response.statusCode}');
    // }
    // Share.share('Check out this image: ${mapRes[card]['avatar']}');
    String facebookUrl =
        "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(mapRes[card]['avatar'])}";
    launchUrl(Uri.parse(facebookUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> shareX(card) async {
    // Uri twitterUrl =
    //     Uri.parse('https://www.twitter.com//?text=${Uri.encodeFull("hi")}');

    // if (await canLaunch(twitterUrl.toString())) {
    //   await launch(twitterUrl.toString());
    // } else {
    //   print('Could not launch $twitterUrl');
    // }
    // Share.share('Check out this image: ${mapRes[card]['avatar']}');
    String twitterUrl =
        "https://twitter.com/intent/tweet?text=${Uri.encodeFull(mapRes[card]['avatar'])}";
    launchUrl(Uri.parse(twitterUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> shareIG(card) async {
    // Uri instagramUrl =
    //     Uri.parse('https://www.instagram.com//?text=${Uri.encodeFull("hi")}');

    // if (await canLaunch(instagramUrl.toString())) {
    //   await launch(instagramUrl.toString());
    // } else {
    //   print('Could not launch $instagramUrl');
    // }
    // Share.share('Check out this image: ${mapRes[card]['avatar']}');
    String instagramUrl =
        "https://www.instagram.com//?text=${Uri.encodeFull("hi")}";
    launchUrl(Uri.parse(instagramUrl), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(173, 216, 230, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 185, 185, 1),
        title: Text(
          'HOME 🏠',
          style: GoogleFonts.robotoSlab(
              fontSize: 25, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        leading: PopupMenuButton<String>(
          iconSize: 30,
          itemBuilder: (BuildContext context) {
            return [
              {'label': 'Recharge', 'icon': Icons.currency_rupee_sharp},
              {'label': 'Sign Out', 'icon': Icons.exit_to_app},
            ].map(
              (item) {
                return PopupMenuItem<String>(
                  value: (item['label'] as String).toLowerCase(),
                  child: Row(
                    children: [
                      Icon(item['icon'] as IconData),
                      SizedBox(width: 10),
                      Text(item['label'] as String),
                    ],
                  ),
                );
              },
            ).toList();
          },
          onSelected: (String value) {
            if (value == 'recharge') {
              // Navigate to the recharge page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RechargePage()),
              );
            } else if (value == 'signout') {}
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RechargePage()),
                );
              },
              icon: Icon(Icons.account_balance_wallet))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Card curr = Card(
              color: Color.fromRGBO(173, 216, 230, 1),
              child: Column(children: [
                Image.network(
                  mapRes[index]['avatar'], // Dummy image URL
                  height: 400,
                  // Increased image size
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ]),
            );
            return Column(
              children: [
                curr,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        // shareWA(mapRes[index]['avatar']);
                        shareWA(index);
                      },
                      icon: Image.asset('PNG/whatsapp.png'),
                    ),
                    IconButton(
                      onPressed: () {
                        shareFB(index);
                      },
                      icon: Image.asset('PNG/facebook.png'),
                    ),
                    IconButton(
                      onPressed: () {
                        shareX(index);
                      },
                      icon: Image.asset('PNG/x.png'),
                      iconSize: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        shareIG(index);
                      },
                      icon: Image.asset('PNG/instagram.png'),
                    )
                  ],
                )
              ],
            );
          },
          itemCount: mapRes.length,
        ),
      ),
    );
  }
}