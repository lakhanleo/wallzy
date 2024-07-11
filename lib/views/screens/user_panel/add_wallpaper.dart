import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:wallzy/Common/CommonWidgets.dart';
import 'dart:io';

import 'package:wallzy/service/database.dart';

class AddWallpaper extends StatefulWidget {
  const AddWallpaper({super.key});

  @override
  State<AddWallpaper> createState() => _AddWallpaperState();
}

class _AddWallpaperState extends State<AddWallpaper> {
  final List<String> categortItems = ["Wildlife", "Food", "Nature", "City"];
  String? selectedValue;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage()async{
    var image = await _picker.pickImage(source:  ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {
    });
  }

  uploadItem() async{
    if (selectedImage!=null){
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String,dynamic> addItem = {
        "Image" : downloadUrl,
        "Id" : addId,
      };
      ///loading
      showDialog(context: context, builder: (context) {
        return Center(child: Lottie.asset('lib/assets/animations/blue-loader.json'));
      },);
      ///function
      await DatabaseMethods().addWallpaper(addItem, addId, selectedValue!).then((value){
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Yeah!!',
            message:
            " You've successfully uploaded the wallpaper, ",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      });
      ///pop
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF373866),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            "Add Wallpaper",
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
            verticalSpace(20),
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: (selectedImage==null) ? Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 300,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                        // border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.upload_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ) : Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        // border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.file(selectedImage!,fit: BoxFit.cover,)),
                  ),
                ),
              ),
            ),
            verticalSpace(20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      items: categortItems.map((item) => DropdownMenuItem(
                            child: Text(
                              item,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            value: item,
                          )).toList(),
                      onChanged: (value) => setState(() {
                        this.selectedValue = value;
                      }),hint: Text("Select Category"),value: selectedValue,)),
            ),
            verticalSpace(40),
            GestureDetector(
              onTap: () {
                uploadItem();
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12),
                margin:
                const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.blue.shade50,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
