import 'dart:async';
import 'package:ai_assistent/about_us.dart';
import 'package:ai_assistent/site_webview.dart';
import 'package:ai_assistent/web_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'color.dart';
import 'data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;


  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }


  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70.h,
        width: double.infinity,
        decoration:const BoxDecoration(
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 0.0,
                blurRadius: 0.0,
                offset: Offset(0, 0,), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SiteWebView(),
                  ),
                );
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: SvgPicture.asset(
                    "assets/images/internet_icon.svg",
                    height: 25.h,
                  ),
                ),
              ),
            )),
            Expanded(child: Container(
              child: SvgPicture.asset(
                "assets/images/home.svg",
                height: 55.h,
              ),
            )),
            Expanded(child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  ),
                );
              },
              child: Container(
                child: const Padding(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Icon(Icons.groups,size: 40,color: Color(0xffd5d4d4),)
                ),
              ),
            )),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.h,
              bottom: 0.h,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 150.h,
                            decoration:const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.colorBlueGradientStart, AppColors.colorBlueGradientEnd],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    bottomRight: Radius.circular(60))
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 40.0),
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/menu.png",
                                    height: 48.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome Sir!',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.colorDisabled
                                          ),
                                        ),
                                        Text(
                                          'I’m your AI Assistant!!',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h,),
                            CarouselSlider(
                              items: [
                                Container(
                                  margin: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/banner_one.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/banner_two.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/banner_three.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                              options: CarouselOptions(
                                height: 150.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: -5.0,
                                      blurRadius: 4.0,
                                      offset: Offset(0, 0,), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 330.h,
                                width: 330.w,
                                padding: const EdgeInsets.all(8),
                                child: GridView.builder(
                                  physics: const ScrollPhysics(),
                                  itemCount: myData.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 4,
                                    childAspectRatio: 4 / 5, // Adjust the aspect ratio to fit your needs
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebScreen(id: myData[index]['id'],),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 56.h,
                                            width: 56.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[300]!),
                                              borderRadius: BorderRadius.circular(8),
                                              color: myData[index]['color']
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                myData[index]['icon'],
                                                height: 38.h,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:2.0),
                                            child: Text(
                                                myData[index]['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
