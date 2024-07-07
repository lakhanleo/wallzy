import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallzy/Common/CommonWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> WallpaperImageList = [
    "lib/assets/images/wallpaper1.jpg",
    "lib/assets/images/wallpaper2.jpeg",
    "lib/assets/images/wallpaper3.png",
    "lib/assets/images/wallpaper4.png",
  ];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset(
                "lib/assets/images/profile_placeholder.png",
                height: 30,
                width: 30,
              ),
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            "Wallzy",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "Outfit"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          children: [
            // verticalSpace(30),
            CarouselSlider.builder(
                itemCount: WallpaperImageList.length,
                itemBuilder: (context, index, realIndex) {
                  final result = WallpaperImageList[index];
                  return buildImage(result, index);
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 1.5,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                )),
            verticalSpace(20),
            Center(
              child: buildIndicator(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage(String ImageUrl, int index) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            ImageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: WallpaperImageList.length,
        effect: ColorTransitionEffect(
            dotWidth: 15,
            dotHeight: 15,
            activeDotColor: Colors.deepOrangeAccent),
      );
}
