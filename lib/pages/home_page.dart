import 'package:authify_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../utilities/animations/login_page_animation.dart';
import '../utilities/page_routes/slide_page_route.dart';

class AnimatedHomePage extends StatefulWidget {
  final String name;

  const AnimatedHomePage({super.key, required this.name});

  @override
  State<AnimatedHomePage> createState() => _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<AnimatedHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1400),
        reverseDuration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(controller: _controller, animation: EnterAnimation(_controller), name: widget.name);
  }
}

class HomePage extends StatelessWidget {
  final AnimationController controller;
  final EnterAnimation animation;
  final String name;

  HomePage({super.key, required this.controller, required this.animation, required this.name}) {
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<Color>(
          valueListenable: themeColor, // Listen to theme color
          builder: (context, color, child) {
            return Container(
              color: Colors.white,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: deviceHeight * 0.65,
                  width: deviceWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _avatarWidget(color, deviceHeight),
                      SizedBox(height: deviceHeight * 0.03),
                      _nameWidget(color),
                      SizedBox(height: deviceHeight * 0.20),
                      _logoutButton(context, color, deviceWidth, deviceHeight),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Avatar widget with light theme color
  Widget _avatarWidget(Color lightThemeColor, double deviceHeight) {
    double circleD = deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: animation.controller,
      builder: (BuildContext context, Widget? widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
              animation.circleSize.value, animation.circleSize.value, 1),
          child: Container(
            height: circleD,
            width: circleD,
            decoration: BoxDecoration(
              color: lightThemeColor, // Use the lighter theme color
              borderRadius: BorderRadius.circular(500),
              image: const DecorationImage(
                image: AssetImage('assets/images/main_avatar.png'),
              ),
            ),
          ),
        );
      },
    );
  }

  // Display user's name with light theme color
  Widget _nameWidget(Color lightThemeColor) {
    return Text(
      name.isNotEmpty ? name : "John Doe", // Use entered name or fallback to default
      style: TextStyle(
          color: lightThemeColor,  // Use light theme color for text
          fontSize: 35,
          fontWeight: FontWeight.w400),
    );
  }

  // Logout button with light theme color
  Widget _logoutButton(BuildContext context, Color lightThemeColor, double deviceWidth, double deviceHeight) {
    return MaterialButton(
      minWidth: deviceWidth * 0.38,
      height: deviceHeight * 0.085,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(color: lightThemeColor, width: 3), // Use light theme color for border
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          SlidePageRoute(
            const AnimatedLoginPage(),
          ),
        );
      },
      child: Text(
        "LOG OUT",
        style: TextStyle(
            fontSize: 18,
            color: lightThemeColor,  // Use light theme color for text
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
