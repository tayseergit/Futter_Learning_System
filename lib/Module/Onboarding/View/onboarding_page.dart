import 'package:learning_project/Constant/images.dart';
import 'package:learning_project/Constant/public_constant.dart';
import 'package:learning_project/Helper/cach_helper.dart';
import 'package:learning_project/Module/Languages/View/lang_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome",
      "description": "Discover delicious meals delivered fast.",
      "image": Images.onboard1,
    },
    {
      "title": "Track",
      "description": "Follow your order in real time.",
      "image": Images.onboard2,
    },
    {
      "title": "Enjoy",
      "description": "Experience fast, reliable learning_project.",
      "image": Images.onboard3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          final data = onboardingData[index];
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(data['image']!, height: 300),
                const SizedBox(height: 30),
                Text(
                  data['title']!,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  data['description']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet:
          _currentPage == onboardingData.length - 1
              ? TextButton(
                onPressed: () {
                  CacheHelper.saveData(key: "onboard", value: "true");

                  pushAndRemoveUntiTo(
                    context: context,
                    toPage: LanguageSelectionPage(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    height: 50.h,
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
              : Container(
                height: 60,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed:
                          () =>
                              _controller.jumpToPage(onboardingData.length - 1),
                      child: const Text("Skip"),
                    ),
                    Row(
                      children: List.generate(
                        onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentPage == index ? 20 : 8,
                          decoration: BoxDecoration(
                            color:
                                _currentPage == index
                                    ? Colors.blue
                                    : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed:
                          () => _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease,
                          ),
                      child: Container(child: const Text("Next")),
                    ),
                  ],
                ),
              ),
    );
  }
}
