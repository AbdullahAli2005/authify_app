import 'package:authify_app/pages/home_page.dart';
import 'package:authify_app/utilities/animations/login_page_animation.dart';
import 'package:authify_app/utilities/page_routes/fade_page_route.dart';
import 'package:flutter/material.dart';
import 'dart:math';


final ValueNotifier<Color> themeColor = ValueNotifier<Color>(const Color.fromRGBO(125, 191, 211, 1.0));

// Function to calculate a lighter shade of a color
Color calculateLightColor(Color color) {
  return Color.fromARGB(
    color.alpha,
    min(color.red + 60, 255),
    min(color.green + 60, 255),
    min(color.blue + 60, 255),
  );
}

class AnimatedLoginPage extends StatefulWidget {
  const AnimatedLoginPage({super.key});

  @override
  State<AnimatedLoginPage> createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
        reverseDuration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LoginPage(_controller, EnterAnimation(_controller));
  }
}

// ignore: must_be_immutable
class _LoginPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AnimationController _controller;
  final EnterAnimation _animation;

  _LoginPage(this._controller, this._animation) {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate device dimensions directly in the build method
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ValueListenableBuilder<Color>(
          valueListenable: themeColor,
          builder: (context, color, child) {
            final lightThemeColor = calculateLightColor(color);
            return Container(
              color: color,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.white),
                        onPressed: _changeTheme,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: deviceHeight * 0.82,
                        width: deviceWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _avatarWidget(lightThemeColor, deviceHeight),
                            SizedBox(height: deviceHeight * 0.02),
                            _nameTextField(deviceWidth),
                            _emailTextField(deviceWidth),
                            _passwordTextField(deviceWidth),
                            SizedBox(height: deviceHeight * 0.14),
                            _loginButton(context, color, deviceWidth, deviceHeight),
                            SizedBox(height: deviceHeight * 0.08),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _changeTheme() {
    List<Color> colors = [
      const Color.fromARGB(255, 93, 230, 97),
      const Color.fromARGB(255, 6, 129, 10),
      Colors.red,
      Colors.orange,
      Colors.greenAccent,
      Colors.indigo,
      Colors.black,
      Colors.grey,
      Colors.blueGrey,
      Colors.purple,
      Colors.blue,
      const Color.fromARGB(255, 18, 84, 138),
      Colors.pink,
    ];
    themeColor.value = (colors..shuffle()).first;
  }

  Widget _avatarWidget(Color lightThemeColor, double deviceHeight) {
    double circleDiameter = deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _animation.controller,
      builder: (BuildContext context, Widget? widget) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
              _animation.circleSize.value, _animation.circleSize.value, 1),
          child: Container(
            height: circleDiameter,
            width: circleDiameter,
            decoration: BoxDecoration(
              color: lightThemeColor,
              borderRadius: BorderRadius.circular(500),
              image: const DecorationImage(
                image: AssetImage("assets/images/main_avatar.png"),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _nameTextField(double deviceWidth) {
    return SizedBox(
      width: deviceWidth * 0.70,
      child: TextField(
        controller: _nameController,
        cursorColor: Colors.white,
        autocorrect: false,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Name",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField(double deviceWidth) {
    return SizedBox(
      width: deviceWidth * 0.70,
      child: TextField(
        controller: _emailController,
        cursorColor: Colors.white,
        autocorrect: false,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Username",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField(double deviceWidth) {
    return SizedBox(
      width: deviceWidth * 0.70,
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        cursorColor: Colors.white,
        autocorrect: false,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(
      BuildContext context, Color lightThemeColor, double deviceWidth, double deviceHeight) {
    return MaterialButton(
      minWidth: deviceWidth * 0.38,
      height: deviceHeight * 0.085,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(color: lightThemeColor),
      ),
      onPressed: () async {
        if (_nameController.text.isEmpty ||
            _emailController.text.isEmpty ||
            _passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill all fields!")),
          );
          return;
        }

        await _controller.reverse();
        Navigator.pushReplacement(
          context,
          FadePageRoute(AnimatedHomePage(name: _nameController.text)),
        );
      },
      child: Text(
        "LOG IN",
        style: TextStyle(
            fontSize: 18, color: lightThemeColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
