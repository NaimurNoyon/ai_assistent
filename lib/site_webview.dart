import 'package:ai_assistent/web_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'color.dart';

class SiteWebView extends StatefulWidget {
  const SiteWebView({Key? key}) : super(key: key);

  @override
  State<SiteWebView> createState() => _SiteWebViewState();
}

class _SiteWebViewState extends State<SiteWebView> {
  late WebViewController controllerGlobal;
  late WebViewController controller;
  bool isLoading = true;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://netrocreative.com/'));

  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity=Connectivity();
    return isConnected ? buildMainContent() : buildErrorContent();
  }

  Widget buildMainContent() {
    return StreamBuilder(
      stream: connectivity.onConnectivityChanged,
      builder: (_, snapshot){
        controller.enableZoom(false);
        return snapshot.connectionState==ConnectionState.active?
        snapshot.data!=ConnectivityResult.none?
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.0,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: controller),
              if (isLoading)
                Center(
                  child: Center(
                      child: Container(
                        height: 96,
                        width: 96,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: AppColors.colorPrimary,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                      )),
                ),
            ],
          ),
        ) : Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                    'assets/animation/no_data.json',
                    width: 200.w
                ),
                SizedBox(height: 16.h,),
                const Text('No Internet Connection',style: TextStyle(color: AppColors.colorBlackLowEmp),),
                SizedBox(height: 4.w,),
                Text('Turn on Internet',style: TextStyle(color: AppColors.colorBlackLowEmp,fontSize: 12.sp),),
                const Text('Or'),
                SizedBox(height: 6.h,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 20.h,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //const Icon(Icons.arrow_back_ios_new,size: 10,color: AppColors.colorPrimary),
                        SizedBox(width: 4.w,),
                        Text('Back to Home',style: TextStyle(color: AppColors.colorPrimary,fontSize: 14.sp),),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ) :SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                WebViewWidget(controller: controller),
                if (isLoading)
                  Center(
                    child: Center(
                        child: Container(
                          height: 96,
                          width: 96,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: AppColors.colorPrimary,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        )),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildErrorContent() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                'assets/animation/no_data.json',
                width: 200.w
            ),
            SizedBox(height: 16.h,),
            const Text('No Internet Connection',style: TextStyle(color: AppColors.colorBlackLowEmp),),
            SizedBox(height: 8.h,),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 20.h,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //const Icon(Icons.arrow_back_ios_new,size: 10,color: AppColors.colorPrimary),
                    SizedBox(width: 4.w,),
                    Text('Back to Home',style: TextStyle(color: AppColors.colorPrimary,fontSize: 12.sp),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
