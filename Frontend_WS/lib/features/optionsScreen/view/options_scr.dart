import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wire_sense/main.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/utils/image_res.dart';

class FancyAuthScreen extends StatefulWidget {
  @override
  FancyAuthScreenState createState() => FancyAuthScreenState();
}

class FancyAuthScreenState extends State<FancyAuthScreen>
    with SingleTickerProviderStateMixin {
  bool showLogin = true; // Start with login shown

  late AnimationController _controller;
  final Duration _duration = const Duration(milliseconds: 300);
  final Color _mainBgColor = AppColors.mainThemeColor;
  final Color _accentGreen = const Color(0xFFA7E245);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    // If showLogin is true, we set the controller to 1.0 (login front)
    // If showLogin is false, we set the controller to 0.0 (signup front)
    _controller.value = showLogin ? 1.0 : 0.0;
  }

  void _toggleForms(bool login) {
    setState(() {
      showLogin = login;
      if (showLogin) {
        _controller.forward(); // Animate towards login front
      } else {
        _controller.reverse(); // Animate towards signup front
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var containerWidth = screenWidth * 0.25;

    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xff314BB5),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTabButton(
                          "FOR", showLogin, () => _toggleForms(true)),
                      const SizedBox(width: 40),
                      _buildTabButton(
                          "REV", !showLogin, () => _toggleForms(false)),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: containerWidth,
                    height: screenHeight * 0.6,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        // controller.value = t in [0,1]
                        // t=1: login front, t=0: signup front

                        // Positions and scaling based on t:
                        // When login front (t=1):
                        //   login: near left (-0.2), y slightly up (-20), scale=1.0
                        //   signup: far right (+0.8), y=+10, scale=0.8
                        // When signup front (t=0):
                        //   signup: near right (+0.2), y=-20, scale=1.0
                        //   login: far left (-0.8), y=+10, scale=0.8

                        double t = _controller.value;
                        // Interpolate values for login form
                        double loginX = lerpDouble(-0.65, -0.2, t)!;
                        double loginY = lerpDouble(10.0, -20.0, t)!;
                        double loginScale = lerpDouble(0.8, 1.0, t)!;
                        Color loginBg = Color.lerp(
                            const Color(0xFFD7E7F1), Colors.white, t)!;

                        // Interpolate values for signup form
                        double signupX = lerpDouble(0.35, 0.8, t)!;
                        double signupY = lerpDouble(-20.0, 10.0, t)!;
                        double signupScale = lerpDouble(1.0, 0.8, t)!;
                        Color signupBg = Color.lerp(
                            Colors.white, const Color(0xFFD7E7F1), t)!;

                        // If showLogin = true, login is front, signup behind
                        // If showLogin = false, signup is front, login behind
                        // We can reorder stack children based on showLogin:
                        Widget behindForm, frontForm;

                        if (showLogin) {
                          // Login front
                          behindForm = _buildPositionedForm(
                            x: signupX,
                            y: signupY,
                            scale: signupScale,
                            width: containerWidth * 0.5,
                            color: signupBg,
                            child: Opacity(
                              opacity: 1.0 - t,
                              child: _buildParameterForm(),
                            ),
                          );

                          frontForm = _buildPositionedForm(
                            x: loginX,
                            y: loginY,
                            scale: loginScale,
                            width: containerWidth,
                            color: loginBg,
                            child: Opacity(
                              opacity: t,
                              child: _buildPredictPropertiesForm(screenHeight),
                            ),
                          );
                        } else {
                          // Signup front
                          behindForm = _buildPositionedForm(
                            x: loginX,
                            y: loginY,
                            scale: loginScale,
                            width: containerWidth * 0.5,
                            color: loginBg,
                            child: Opacity(
                              opacity: t,
                              child: _buildPredictPropertiesForm(screenHeight),
                            ),
                          );

                          frontForm = _buildPositionedForm(
                            x: lerpDouble(0.35, 0.2, 1 - t)!,
                            // Adjust to center it a bit more nicely
                            y: lerpDouble(-20.0, -20.0, 1 - t)!,
                            scale: lerpDouble(1.0, 1.0, 1 - t)!,
                            width: containerWidth,
                            color: signupBg,
                            child: Opacity(
                              opacity: 1.0 - (1.0 - t),
                              child: _buildParameterForm(),
                            ),
                          );
                          // Actually, for signup front, we already have signupX,
                          // let's just reuse them for simplicity:
                          double sX = lerpDouble(0.35, 0.2, t)!;
                          double sY = -20.0;
                          double sScale = 1.0;
                          frontForm = _buildPositionedForm(
                            x: sX,
                            y: sY,
                            scale: sScale,
                            width: containerWidth,
                            color: signupBg,
                            child: _buildParameterForm(),
                          );
                        }

                        return Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            behindForm,
                            frontForm,
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPositionedForm({
    required double x,
    required double y,
    required double scale,
    required double width,
    required Color color,
    required Widget child,
  }) {
    return Positioned.fill(
      child: Transform(
        transform: Matrix4.identity()
          ..translate(x * width, y)
          ..scale(1.0, scale),
        origin: Offset(width / 2, 0),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: child,
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
              color: active ? Colors.white : Colors.grey[400],
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 60,
            height: 2,
            color: active ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildPredictPropertiesForm(double screenHeight) {
    ///forward
    return GestureDetector(
      onTap: (){
        navKey.currentState?.pushNamed("/dashboard");
      },
      child: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageRes.forward_model_icon,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.grey.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Text overlay
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Predict Properties',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   'Feel the beauty around you',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     color: Colors.white.withOpacity(0.9),
                  //     fontStyle: FontStyle.italic,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterForm() {
    /// reverse
    return GestureDetector(
      onTap: (){
        // todo - get to the reverse model
        // navKey.currentState?.pushNamed("/");
      },
      child: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageRes.reverse_model_icon,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.grey.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Text overlay
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Get Parameters',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   'Feel the beauty around you',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     color: Colors.white.withOpacity(0.9),
                  //     fontStyle: FontStyle.italic,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
