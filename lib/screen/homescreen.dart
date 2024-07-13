import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:cmru_application/confg/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];
  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('$API_URL/api/banners'));
      final banners = jsonDecode(response.body);
      print(banners);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Container(
        child: Swiper(
          autoplay: true,
          itemCount: banners.length,
          itemBuilder: (context, index) {
            return Image.network(
              '$API_URL/${banners[index]['imageUrl']}',
              fit: BoxFit.fitHeight,
            );
          },
        ),
      ),
    );
  }
}
