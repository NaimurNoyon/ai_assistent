import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'color.dart';
import 'data.dart';
import 'home_screen.dart';

class WebScreen extends StatefulWidget {
  final int id;

  const WebScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

Connectivity connectivity=Connectivity();

class _WebScreenState extends State<WebScreen> {
  late WebViewController controllerGlobal;
  late WebViewController controller;
  bool isLoading = true;
  bool isConnected = true;

  late final RewardedAd rewardedAd;
  final String rewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917";


  //method to load an ad
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request:const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        //when failed to load
        onAdFailedToLoad: (LoadAdError error){
          print("Failed to load rewarded ad, Error: $error");
        },
        //when loaded
        onAdLoaded: (RewardedAd ad){
          print("$ad loaded");
          // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;

          //set on full screen content call back
          _setFullScreenContentCallback();
        },
      ),
    );
  }

  //method to set show content call back
  void _setFullScreenContentCallback(){
    if(rewardedAd == null) return;
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      //when ad  shows fullscreen
      onAdShowedFullScreenContent: (RewardedAd ad) => print("$ad onAdShowedFullScreenContent"),
      //when ad dismissed by user
      onAdDismissedFullScreenContent: (RewardedAd ad){
        print("$ad onAdDismissedFullScreenContent");

        //dispose the dismissed ad
        ad.dispose();
      },
      //when ad fails to show
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
        print("$ad  onAdFailedToShowFullScreenContent: $error ");
        //dispose the failed ad
        ad.dispose();
      },

      //when impression is detected
      onAdImpression: (RewardedAd ad) =>print("$ad Impression occured"),
    );

  }

  //show ad method
  void _showRewardedAd(){
    //this method take a on user earned reward call back
    rewardedAd.show(
      //user earned a reward
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
          //reward user for watching your ad
          num amount = rewardItem.amount;
          print("You earned: $amount");
        }
    );
  }

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
      ..loadRequest(Uri.parse(myData[widget.id]['link']));

    _loadRewardedAd();
  }

  @override
  void dispose() {
    super.dispose();
    _showRewardedAd();
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
            //bottomNavigationBar:
            appBar: AppBar(
              backgroundColor: AppColors.colorPrimary,
              title: Text(myData[widget.id]['appbar']),
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
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: AppColors.colorPrimary,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        )),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Container(
                      height: 70.h,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1.0,
                            blurRadius: 5.0,
                            offset: Offset(1, 1,), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebScreen(id: widget.id == 0
                                          ? myData[11]['id']
                                          : myData[widget.id - 1]['id'],),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: widget.id == 0
                                      ? myData[11]['color']
                                      : myData[widget.id - 1]['color'],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      widget.id == 0
                                          ? myData[11]['icon']
                                          : myData[widget.id - 1]['icon'],
                                      height: 25.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                          Expanded(child: Container(
                            child: InkWell(
                              onTap: (){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/images/home.svg",
                                height: 55.h,
                              ),
                            ),
                          )),
                          Expanded(child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebScreen(id: widget.id == 11
                                          ? myData[0]['id']
                                          : myData[widget.id + 1]['id'],),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: widget.id == 11
                                      ? myData[0]['color']
                                      : myData[widget.id + 1]['color'],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      widget.id == 11
                                          ? myData[0]['icon']
                                          : myData[widget.id + 1]['icon'],
                                      height: 25.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                )
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
          ) :Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.colorPrimary,
              title: Text(myData[widget.id]['appbar']),
            ),
            body: Stack(
              children: [
                WebViewWidget(controller: controller),
                SizedBox(height: 150.h,),
                if (isLoading)
                  Center(
                    child: Center(
                        child: Container(
                          height: 96,
                          width: 96,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: AppColors.colorPrimary,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        )),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Container(
                      height: 70.h,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1.0,
                            blurRadius: 5.0,
                            offset: Offset(1, 1,), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebScreen(id: widget.id == 0
                                          ? myData[11]['id']
                                          : myData[widget.id - 1]['id'],),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: widget.id == 0
                                      ? myData[11]['color']
                                      : myData[widget.id - 1]['color'],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      widget.id == 0
                                          ? myData[11]['icon']
                                          : myData[widget.id - 1]['icon'],
                                      height: 25.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                          Expanded(child: Container(
                            child: InkWell(
                              onTap: (){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                "assets/images/home.svg",
                                height: 55.h,
                              ),
                            ),
                          )),
                          Expanded(child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebScreen(id: widget.id == 11
                                          ? myData[0]['id']
                                          : myData[widget.id + 1]['id'],),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: widget.id == 11
                                      ? myData[0]['color']
                                      : myData[widget.id + 1]['color'],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      widget.id == 11
                                          ? myData[0]['icon']
                                          : myData[widget.id + 1]['icon'],
                                      height: 25.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
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

