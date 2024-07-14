import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:wallzy/Common/CommonWidgets.dart';
import 'package:wallzy/views/components/widget.dart';

import '../../models/photo_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotosModel> photos = [];

  /// searchTEC
  TextEditingController searchTEC = TextEditingController();
  bool isSearched = false;

  ///get wallapeper function
  getSearchedWallpaper(String searchQuery) async {
    ///loading phase
    showDialog(context: context, builder: (context) {
      return Center(child: Lottie.asset('lib/assets/animations/loading.json'));
    },);
    ///api hit
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$searchQuery&per_page=30"),headers: {
          "Authorization":
              "nBoDsSLcBEwqxTLiO7wfFl31TFQTWV9iUuC78GAXlZGITV1Lx7b9jm4a"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      setState(() {
        isSearched = true;

        log("***************************************");
        log("api hit");
        log("***************************************");

      });
    });
    Navigator.of(context).pop();
  }

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
            "Search",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "Outfit"),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => getSearchedWallpaper(value),
                controller: searchTEC,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: isSearched ? GestureDetector(
                        onTap: () {
                          photos=[];
                          isSearched=false;
                          searchTEC.clear();
                          setState(() {});
                        },
                        child:  Icon(
                          Icons.close_outlined,
                          color: const Color.fromARGB(255, 84, 87, 93),
                        )) : GestureDetector(
                        onTap: () {
                          getSearchedWallpaper(searchTEC.text);
                        },
                        child:  Icon(
                          Icons.search_outlined,
                          color: const Color.fromARGB(255, 84, 87, 93),
                        )),
                ),
              ),
            ),
            verticalSpace(20),
            Expanded(child: wallpaper(photos, context))
          ],
        ),
      ),
    );
  }
}
