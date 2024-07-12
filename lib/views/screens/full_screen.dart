import 'dart:developer';
import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FullScreen extends StatefulWidget {
  final String imagepath;
  const FullScreen({super.key,required this.imagepath});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

  _save() async {
    var response = await Dio().get(widget.imagepath,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Yeah!!',
        message:
        " You've saved the wallpaper in your gallery. ",
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///wallpaper
          Hero(tag: widget.imagepath, child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(imageUrl: widget.imagepath,fit: BoxFit.cover,),
          )),
          ///set wallpaper
          Positioned(
            bottom: 130,right: 15,
            child: GestureDetector(
              onTap: () {
                _save();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2,color: Colors.white),
                    gradient: const RadialGradient(colors: [Colors.white38,Colors.white30,Colors.white24,])
                ),
                child: const Icon(Icons.download,color: Colors.white,),
              ),
            ),
          ),
          ///cancel
          Positioned(
            bottom: 70,right: 15,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2,color: Colors.white),
                    gradient: const RadialGradient(colors: [Colors.white38,Colors.white30,Colors.white24,])
                ),
                child: const Icon(Icons.close_outlined,color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
