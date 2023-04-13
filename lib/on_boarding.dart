import 'package:ai_assistent/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'home_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 5.0,
      width: isActive ? 24.0 : 20.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white70,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget> [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/onboarding-1.png"),
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                  Positioned(
                      top: 60.h,
                      left: 10.w,
                      right: 10.w,
                      child: Column(
                        children: [
                          Text(
                            'AI Personal\nAssistant App',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorPrimaryDark
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          Text(
                            'An App that can assists you all the way long\nand without any cost or subscription!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.bold,
                                color: AppColors.colorDisabled
                            ),
                          ),
                          SizedBox(height: 18.h,),
                        ],
                      )
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/onboarding-2.png"),
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                  Positioned(
                      top: 60.h,
                      left: 10.w,
                      right: 10.w,
                      child: Column(
                        children: [
                          Text(
                            'Say Hello to Your\nSmart Assistant!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorPrimaryDark
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          Text(
                            'An App that can assists you all the way long\nand without any cost or subscription!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.bold,
                                color: AppColors.colorDisabled
                            ),
                          ),
                          SizedBox(height: 18.h,),
                        ],
                      )
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/onboarding-3.png"),
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                  Positioned(
                      top: 60.h,
                      left: 10.w,
                      right: 10.w,
                      child: Column(
                        children: [
                          Text(
                            'AI Assistro\nSmartest of All',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorPrimaryDark
                            ),
                          ),
                          SizedBox(height: 8.h,),
                          Text(
                            'Your new AI-powered assistant is here to\nmake your life easier.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.bold,
                                color: AppColors.colorDisabled
                            ),
                          ),
                          SizedBox(height: 18.h,),
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 25.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
          Positioned(
            top: 210.h,
            left: 20.w,
            right: 20.w,
              child: InkWell(
                onTap: () {
                  if (_currentPage == 2) {
                    // Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                child: SvgPicture.asset(
                  "assets/images/next.svg",
                  height: 70.h,
                ),
              ),
          )
        ],
      )
    );
  }
}
