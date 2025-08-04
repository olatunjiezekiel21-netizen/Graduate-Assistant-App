import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      image: Icons.tv, // Placeholder icon
      text: 'With Graduate guide you get to have available information on the available job offers.',
      buttonText: 'REGISTER',
    ),
    _OnboardingPageData(
      image: Icons.show_chart, // Placeholder icon
      text: 'With graduate guide you get to know the necessary documents needed to further yourself into Master program.',
      buttonText: 'NEXT',
    ),
    _OnboardingPageData(
      image: Icons.description, // Placeholder icon
      text: 'With Graduate guide you get to have access to a guide o how to build a solid and standard resume.',
      buttonText: 'NEXT',
    ),
    _OnboardingPageData(
      image: Icons.menu_book, // Placeholder icon
      text: 'Graduate guide is an application design to assist graduate to navigate their next stage of their life.',
      buttonText: 'NEXT',
    ),
  ];

  void _onSkip() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24.0, top: 8),
                        child: GestureDetector(
                          onTap: _onSkip,
                          child: Text('Skip', style: TextStyle(color: Colors.purple, fontSize: 18)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(page.image, size: 180, color: Colors.purple.shade200),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        page.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (dotIndex) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 32,
                          height: 6,
                          decoration: BoxDecoration(
                            color: dotIndex == _currentPage ? Colors.purple : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _onNext,
                          child: Text(
                            page.buttonText,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  final IconData image;
  final String text;
  final String buttonText;

  _OnboardingPageData({required this.image, required this.text, required this.buttonText});
} 