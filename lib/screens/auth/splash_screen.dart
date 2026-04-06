import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 4-second loop for a slow, continuous floating effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensuring status bar icons are white using SystemUiOverlayStyle.light
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.23, 1.0],
              colors: const [
                Color(0xFF18181B), // Dark grayish black
                Color(0xFF2B8761), // Vibrant green
              ],
            ),
          ),
          child: Stack(
            children: [
              // Background wave pattern at the top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/Wave-circle.png',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),

              // Central hero element with "Antigravity" floating animation
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          // Oscillates smoothly between -12 and +12 vertically
                          final dy =
                              math.sin(_controller.value * 2 * math.pi) * 12;
                          return Transform.translate(
                            offset: Offset(0, dy),
                            child: child,
                          );
                        },
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 40,
                                spreadRadius: 10,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: Image.asset(
                              'assets/images/wallet.png',
                              width:
                                  200, // Replace with your actual 3D wallet asset path
                              fit: BoxFit.contain,
                              // Fallback widget if the asset doesn't exist yet
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF122A25,
                                      ).withOpacity(0.05),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.account_balance_wallet,
                                      size: 80,
                                      color: Color(0xFF122A25),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),

                      // Floating Colored Spheres
                      // Placed relatively dynamically with their own slight variation in float phase

                      // Mint sphere
                      _buildFloatingSphere(
                        size: 16,
                        color: const Color(0xFF5DF9D3), // Mint
                        alignment: const Alignment(-0.75, -0.25),
                        phaseOffset: 1.0,
                        magnitude: 14,
                      ),

                      // Purple sphere
                      _buildFloatingSphere(
                        size: 20,
                        color: const Color(0xFF855AFA), // Purple
                        alignment: const Alignment(-0.35, -0.65),
                        phaseOffset: 2.5,
                        magnitude: 10,
                      ),

                      // Orange sphere
                      _buildFloatingSphere(
                        size: 28,
                        color: const Color(0xFFFFA03A), // Orange
                        alignment: const Alignment(-0.6, 0.45),
                        phaseOffset: 0.5,
                        magnitude: 18,
                      ),

                      // Blue sphere
                      _buildFloatingSphere(
                        size: 18,
                        color: const Color(0xFF007AFF), // Blue
                        alignment: const Alignment(0.65, 0.35),
                        phaseOffset: 4.0,
                        magnitude: 15,
                      ),

                      // Red sphere
                      _buildFloatingSphere(
                        size: 24,
                        color: const Color(0xFFFF3B30), // Red
                        alignment: const Alignment(0.7, -0.35),
                        phaseOffset: 1.8,
                        magnitude: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
          // Adding phase offset ensures spheres float asynchronously
          final dy =
              math.sin((_controller.value * 2 * math.pi) + phaseOffset) *
              magnitude;
          return Transform.translate(offset: Offset(0, dy), child: child);
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.6),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
