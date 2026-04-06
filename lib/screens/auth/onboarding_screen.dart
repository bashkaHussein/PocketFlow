import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pocket_flow/screens/auth/login_screen.dart';
import 'package:pocket_flow/screens/auth/login_screen_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      icon: Icons.insights_rounded,
      title: 'Track Your Expenses',
      description:
          'Easily monitor where your money goes every day and stay within your budget.',
    ),
    OnboardingData(
      icon: Icons.savings_rounded,
      title: 'Smart Savings',
      description:
          'Set goals and achieve them with our intelligent saving tips and tracking.',
    ),
    OnboardingData(
      icon: Icons.security_rounded,
      title: 'Secure & Reliable',
      description:
          'Your financial data is protected with bank-grade security and encryption.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          const WaveBackground(),
          SafeArea(
            child: Column(
              children: [
                // Header Row with Back and Skip Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        IconButton(
                          onPressed: _onBack,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.primaryGreen,
                            size: 20,
                          ),
                        )
                      else
                        const SizedBox(width: 48),
                      TextButton(
                        onPressed: _goToLogin,
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return _buildPage(_pages[index]);
                    },
                  ),
                ),
                // Indicators and Next/Get Started Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => _buildIndicator(index),
                        ),
                      ),
                      const SizedBox(height: 48),
                      CustomButton(
                        text: _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        onPressed: _onNext,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 220,
            width: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildFloatingSphere(
                  size: 12,
                  color: const Color(0xFF5DF9D3),
                  alignment: const Alignment(-0.8, -0.4),
                  phaseOffset: 1.0,
                  magnitude: 10,
                ),
                _buildFloatingSphere(
                  size: 16,
                  color: const Color(0xFF855AFA),
                  alignment: const Alignment(0.7, -0.6),
                  phaseOffset: 2.5,
                  magnitude: 8,
                ),
                _buildFloatingSphere(
                  size: 20,
                  color: const Color(0xFFFFA03A),
                  alignment: const Alignment(-0.6, 0.7),
                  phaseOffset: 0.5,
                  magnitude: 12,
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final dy = math.sin(_controller.value * 2 * math.pi) * 10;
                    return Transform.translate(
                      offset: Offset(0, dy),
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.08),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGreen.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(data.icon, size: 100, color: AppColors.primaryGreen),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingSphere({
    required double size,
    required Color color,
    required Alignment alignment,
    required double phaseOffset,
    required double magnitude,
  }) {
    return Align(
      alignment: alignment,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final dy =
              math.sin((_controller.value * 2 * math.pi) + phaseOffset) *
              magnitude;
          return Transform.translate(offset: Offset(0, dy), child: child);
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryGreen
            : AppColors.borderGrey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingData {
  final IconData icon;
  final String title;
  final String description;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
