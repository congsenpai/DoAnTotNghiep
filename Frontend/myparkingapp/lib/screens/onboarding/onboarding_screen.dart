import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import '../../constants.dart';
import '../../components/dot_indicators.dart';
import '../auth/sign_in_screen.dart';
import 'components/onboard_content.dart';

class OnboardingScreen extends StatefulWidget {
  final Function(Locale) changeLanguage;
  const OnboardingScreen({super.key, required this.changeLanguage});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate("chooseLanguage")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                Get.updateLocale(const Locale('en')); // hoặc Locale('en')
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("VietNam"),
              onTap: () {
                Get.updateLocale(const Locale('vi')); // hoặc Locale('vi')
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 14,
              child: PageView.builder(
                itemCount: demoData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  illustration: demoData[index]["illustration"],
                  title: demoData[index]["title"],
                  text: demoData[index]["text"],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                demoData.length,
                    (index) => DotIndicator(isActive: index == currentPage),
              ),
            ),
            const Spacer(flex: 2),
            Container(
              width: Get.width/2,
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                child: Text(AppLocalizations.of(context).translate("getStarted").toUpperCase()),
              ),
            ),
            const Spacer(flex: 1),
            Container(
              width: Get.width/1.5,
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ElevatedButton(
                onPressed: _showLanguageDialog,
                child: Text(AppLocalizations.of(context).translate("chooseLanguage").toUpperCase()),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
// Demo data for our Onboarding screen
List<Map<String, dynamic>> demoData = [
  {
    "illustration": "assets/Illustrations/Illustrations_1.svg",
    "title": "title1",
    "text": "text1"
  },
  {
    "illustration": "assets/Illustrations/Illustrations_2.svg",
    "title": "title2",
    "text": "text2"
  },
  {
    "illustration": "assets/Illustrations/Illustrations_3.svg",
    "title": "title3",
    "text": "text3"
  }
];
