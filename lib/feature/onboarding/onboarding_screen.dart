import 'package:flutter/material.dart';
import 'package:newsapp/feature/onboarding/models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: OnboardingModel.onboardingList.length,
        itemBuilder: (BuildContext context, int index) {
          final model = OnboardingModel.onboardingList[index];
          final isLastPage = index == OnboardingModel.onboardingList.length - 1;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child:  isLastPage ? SizedBox(height: 25,) :TextButton(
                    onPressed: _navigateToHome,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Image.asset(model.image),
                SizedBox(height: 24),
                Text(
                  model.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff4E4B66),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  model.desc,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6E7191),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (!isLastPage) {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.bounceInOut,
                      );
                    } else {
                      _navigateToHome();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 48),
                    backgroundColor: Color(0xffC53030),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: Text(
                    isLastPage ? "Get Started" : "Next",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}