import 'package:flutter/material.dart';
import 'package:newsapp/feature/onboarding/models/onboarding_model.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: OnboardingModel.onboardingList.length,
        itemBuilder: (BuildContext context, int index) {
          final model = OnboardingModel.onboardingList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(onPressed: () {}, child: Text("Skip",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
