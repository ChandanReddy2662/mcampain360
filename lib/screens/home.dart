import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/recharge.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

  void shareWA(card) {
    String whatsappUrl =
        // "whatsapp://send?text=${Uri.encodeFull(mapRes[card]['avatar'])}";
        // "whatsapp://send?text=${mapRes[card]['email']}&image=${Ur=i.encodeComponent(mapRes[card]['avatar'])}";
        "https://api.whatsapp.com/send?${Image.network(Uri.encodeComponent(mapRes[card]['avatar'])).by}";
    // shareWhatsapp.share(text: "hello");
    launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> shareFB(card) async {
    String facebookUrl =
        "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(mapRes[card]['avatar'])}";
    launchUrl(Uri.parse(facebookUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> shareX(card) async {
    String twitterUrl =
        "https://twitter.com/intent/tweet?text=${Uri.encodeComponent(mapRes[card]['avatar'])}";
    launchUrl(Uri.parse(twitterUrl), mode: LaunchMode.externalApplication);
  }

  Future<void> shareIG(card) async {
    String instagramUrl =
        // "https://www.instagram.com//?image=${Uri.encodeFull("hi")}";
        "instagram://library?AssetPath=${mapRes[card]['avatar']}&caption=${'text'}";
    launchUrl(Uri.parse(instagramUrl), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(173, 216, 230, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(250, 185, 185, 1),
        title: Text(
          'HOME',
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
                      const SizedBox(width: 10),
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
              icon: const Icon(Icons.account_balance_wallet))
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
