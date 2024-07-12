import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallzy/Common/CommonWidgets.dart';
import 'package:wallzy/service/database.dart';

import 'full_screen.dart';

class Wallpaper extends StatefulWidget {
  // const Wallpaper({super.key});
  String category;

  Wallpaper({required this.category});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }
  Stream? categoryStream;

  getOnTheLoad()async{
    categoryStream = await DatabaseMethods().getCategory(widget.category);
    setState(() {

    });
  }

  Widget allWallpaper() {
    return StreamBuilder(
      stream: categoryStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                ),itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imagepath: ds["Image"],),));
                    },
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(ds["Image"],fit: BoxFit.cover,),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
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
            "Wallpapers",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "Outfit"),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10,),
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Expanded(child: allWallpaper()),

        ],),
      ),
    );
  }
}
