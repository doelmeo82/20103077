import 'package:flutter/material.dart';
import 'package:flutter_login/custom/custom_button_submit.dart';
import 'package:flutter_login/custom/app_style.dart';
import 'package:flutter_login/models/profile.dart';
import 'package:flutter_login/ui/danhmuc_page.dart';
import 'package:flutter_login/ui/login_page.dart';

// ignore: must_be_immutable

class FullScreenPage extends StatefulWidget {
  const FullScreenPage({
    super.key,
  });
  static const routername = "/";

  @override
  State<FullScreenPage> createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override
  Widget build(BuildContext context) {
    final profile = Profile();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('lib/assets/welcome_logo.png'), 
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => {
                            setState(() {
                            if (profile.token != "") {
                            Navigator.popAndPushNamed(context,
                            PageDashBoard.routername);
                            } else {
                            Navigator.popAndPushNamed(
                              context, PageLogin.routername);
                            }
                          }
                          ),
                    },
                    child: CusTom_ButtonSubmit(textButton: "Let's go")
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}