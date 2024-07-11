import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallzy/Common/CommonWidgets.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:wallzy/views/screens/user_panel/add_wallpaper.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController usernameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45, right: 20, left: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110)),
                  gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight)),
            ),
            Container(
              margin: EdgeInsets.only(right: 30, left: 30, top: 60),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Let's know you\nbetter",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      verticalSpace(30),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: Column(
                            children: [
                              verticalSpace(50),

                              ///username
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color.fromARGB(
                                            255, 160, 160, 147))),
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 5),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                    controller: usernameTEC,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your username";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147)))),
                              ),
                              verticalSpace(30),

                              ///password
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color.fromARGB(
                                            255, 160, 160, 147))),
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 5),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                    controller: passwordTEC,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your password";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147)))),
                              ),
                              verticalSpace(40),

                              ///login
                              GestureDetector(
                                onTap: () {
                                  LoginUser();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: (usernameTEC.text.isEmpty || passwordTEC.text.isEmpty) ? const Color(0xFFededeb) : Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: (usernameTEC.text.isEmpty || passwordTEC.text.isEmpty) ? Colors.black :  const Color(0xFFededeb),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
  LoginUser(){
    FirebaseFirestore.instance.collection("User").get().then((snapshot){
      snapshot.docs.forEach((result) {
        if(result.data()['id'] != usernameTEC.text){
          // AwesomeSnackbarContent(title: "Oops!!", message: "wrong username", contentType: ContentType.failure);
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Oops!!',
              message:
              " It seems you've entered wrong username! ",

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        if(result.data()['password'] != passwordTEC.text){
          // AwesomeSnackbarContent(title: "Oops!!", message: "wrong password", contentType: ContentType.failure);
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Oops!!',
              message:
              " It seems you've entered wrong password. ",

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        else{
          Route route = MaterialPageRoute(builder: (context) => const AddWallpaper(),);
          Navigator.push(context, route);
        }
      });
    });
  }
}
