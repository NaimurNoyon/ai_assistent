import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: const Text('About',style:TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0),
        child: Column(
          children: [
            Container(
              height: 300.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h,),
                  Image.asset(
                    "assets/images/round_logo.png",
                    height: 60.h,
                  ),
                  SizedBox(height: 12.h,),
                  Text(
                    'ProChat',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),
                  Text(
                      'Netro Creative',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xff6318FF)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            const url = 'https://web.facebook.com/netrocreative';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/facebook.svg",
                            height: 20.h,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        InkWell(
                          onTap: () async {
                            const url = 'https://twitter.com/netrocreative';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/twitter.svg",
                            height: 20.h,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        InkWell(
                          onTap: () async {
                            const url = 'https://www.linkedin.com/company/netrocreative/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/linkedin.svg",
                            height: 20.h,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        InkWell(
                          onTap: () async {
                            const url = 'https://wa.me/+8801724244796';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/whatsapp.svg",
                            height: 20.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'ProChat is an AI chat application developed by Netro Creative using the Chat GPT API. It allows users to have natural language conversations with an intelligent virtual assistant, providing helpful information and assisting with various tasks. With advanced language processing capabilities, ProChat can understand and respond to a wide range of queries, making it a versatile and convenient tool for both personal and business use.',
                      style: TextStyle(
                        fontSize: 10.sp
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
