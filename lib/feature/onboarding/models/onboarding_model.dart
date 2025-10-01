class OnboardingModel {
  final String image;
  final String title;
  final String desc;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });

  static List<OnboardingModel> onboardingList =[
    OnboardingModel(image: "assets/images/onboard1.png", title: "Trending News ", desc: "Stay in the loop with the biggest breaking stories in a stunning visual slider. Just swipe to explore what’s trending right now!"),
    OnboardingModel(image: "assets/images/onboard2.png", title: "Pick What You Love", desc: "No more endless scrolling! Tap into your favorite topics like Tech, Politics, or Sports and get personalized news in seconds"),
    OnboardingModel(image: "assets/images/onboard3.png", title: "Save It. Read It Later. Stay Smart.", desc: "Found something interesting? Tap the bookmark and come back to it anytime. Never lose a great read again!"),
  ];
}
