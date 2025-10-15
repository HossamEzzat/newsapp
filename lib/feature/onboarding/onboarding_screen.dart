import 'package:flutter/material.dart';
import 'package:newsapp/feature/main_screen/MainScreen.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/feature/onboarding/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/onboarding_controller.dart';
import '../../core/theme/app_colors.dart';
import '../home/homescreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize page listener after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<OnboardingController>(
        context,
        listen: false,
      );
      controller.pageController.addListener(_pageListener);
    });
  }

  void _pageListener() {
    final controller = Provider.of<OnboardingController>(
      context,
      listen: false,
    );
    if (controller.pageController.page != null) {
      controller.updateCurrentPage(controller.pageController.page!.round());
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Mainscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingController(),
      child: Scaffold(
        body: Consumer<OnboardingController>(
          builder: (context, controller, child) {
            return PageView.builder(
              controller: controller.pageController,
              itemCount: OnboardingModel.onboardingList.length,
              itemBuilder: (BuildContext context, int index) {
                final model = OnboardingModel.onboardingList[index];
                final isLastPage =
                    index == OnboardingModel.onboardingList.length - 1;

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: isLastPage
                            ? SizedBox(height: 25)
                            : TextButton(
                                onPressed: _navigateToHome,
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.asset(model.image, fit: BoxFit.contain),
                      ),
                      SizedBox(height: 24),
                      Text(
                        model.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff4E4B66),
                          fontSize: 24, // Added font size for title
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          model.desc,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff6E7191),
                            fontSize: 16,
                            height:
                                1.5, // Added line height for better readability
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15),
                      SmoothPageIndicator(
                        controller: controller.pageController,
                        // PageController
                        count: 3,
                        effect: SwapEffect(
                          dotColor: Colors.grey,
                          activeDotColor: AppColors.primaryColor,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!isLastPage) {
                              controller.nextPage();
                            } else {
                              _navigateToHome();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            elevation: 0, // Added elevation for consistency
                          ),
                          child: Text(
                            isLastPage ? "Get Started" : "Next",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Added bottom spacing for better layout
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    final controller = Provider.of<OnboardingController>(
      context,
      listen: false,
    );
    controller.pageController.removeListener(_pageListener);
    super.dispose();
  }
}
