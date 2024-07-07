import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            "Categories",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "Outfit"),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10,bottom: 10,right: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "lib/assets/images/wallpaper1.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black38, borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
