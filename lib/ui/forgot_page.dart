import 'package:flutter/material.dart';
import 'package:flutter_login/custom/custom_button_submit.dart';
import 'package:flutter_login/custom/custom_form_input.dart';
import 'package:flutter_login/custom/custom_spiner.dart';
import 'package:flutter_login/custom/app_style.dart';
import 'package:flutter_login/providers/forgot_viewmodel.dart';
import 'package:flutter_login/ui/login_page.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageForgot extends StatefulWidget {
  const PageForgot({super.key});
  static const routername = "/forgot";

  @override
  State<PageForgot> createState() => _PageForgotState();
}

class _PageForgotState extends State<PageForgot> {
  final TextEditingController _emailController = TextEditingController();

  String emailError = '';

  bool isValidEmail = false;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/home.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.6),
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: viewmodel.status == 3
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.blue),
                                        child: const Image(
                                          image: AssetImage(
                                              'lib/assets/confirm_password.png'),
                                        ),
                                      ),
                                    
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 40,
                                        ),
                                        child: InkWell(
                                          onTap: () =>
                                              Navigator.popAndPushNamed(context,
                                                  PageLogin.routername),
                                          child: CusTom_ButtonSubmit(
                                            textButton: 'Log In',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 60,
                                        ),
                                        child: const Image(
                                          image: AssetImage(
                                            'lib/assets/forgot.png',
                                          ),
                                        ),
                                      ),
                                      CusTom_Form_Input(
                                        labelForm: 'Email',
                                        textController: _emailController,
                                        textError: emailError,
                                        isValid: isValidEmail,
                                      ),
                                      viewmodel.status == 2
                                          ? Text(
                                              viewmodel.errorMessage,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            String email =
                                                _emailController.text.trim();
                                            final bool emailValid = RegExp(
                                                    r"^\b[A-Za-z0-9._%+-]+@gmail\.com\b")
                                                .hasMatch(email);
                                            if (email.isEmpty) {
                                              isValidEmail = true;
                                              emailError =
                                                  "You must not leave this field blank!";
                                            } else if (!emailValid) {
                                              isValidEmail = true;
                                              emailError =
                                                  "Invalid email!";
                                            } else {
                                              isValidEmail = false;
                                              viewmodel.forgot(email);
                                            }
                                          });
                                        },
                                        child: CusTom_ButtonSubmit(
                                          textButton: "Send request",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.popAndPushNamed(
                                            context, PageLogin.routername),
                                        child: Text(
                                          'Log In',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue.shade400,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            viewmodel.status == 1 ? const Spiner() : Container(),
          ],
        ),
      ),
    );
  }
}
