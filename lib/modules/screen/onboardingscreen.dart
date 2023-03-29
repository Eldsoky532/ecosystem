import 'package:ecosystem/core/colors/app_colors.dart';
import 'package:ecosystem/core/constant/strings.dart';
import 'package:ecosystem/core/route/route.dart';
import 'package:ecosystem/data/local/cachehelper.dart';
import 'package:ecosystem/models/onboardingmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool islast = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void submit() {
    CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
      if (value) {

        CacheHelper.getData(key: "token")==null?context.go(RouteApp.login):context.go(RouteApp.home);
   // Navigator.pushReplacementNamed(context, RouteApp.signup);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == onBoardinglist.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                  itemCount: onBoardinglist.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: Image(
                            image:
                                AssetImage('${onBoardinglist[index].image}'),

                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '${onBoardinglist[index].title}',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            '${onBoardinglist[index].body}',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: onBoardinglist.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: AppColor.primaryColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: AppColor.primaryColor,
                  onPressed: () {
                    if (islast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
