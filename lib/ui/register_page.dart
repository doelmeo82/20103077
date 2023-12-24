import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/custom/custom_button_submit.dart';
import 'package:flutter_login/custom/custom_form_input.dart';
import 'package:flutter_login/custom/custom_spiner.dart';
import 'package:flutter_login/custom/app_style.dart';
import 'package:flutter_login/providers/register_viewmodel.dart';
import 'package:flutter_login/ui/login_page.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageRegister extends StatefulWidget {
  const PageRegister({super.key});
  static const routername = "/register";
  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _username = TextEditingController();

  late final TextEditingController _password = TextEditingController();

  final TextEditingController _repassword = TextEditingController();

  bool _isChecked = false;

  late bool _isValidEmail = false;
  late bool _isValidUsername = false;
  late bool _isValidPassword = false;
  late bool _isValidRepassword = false;

  // ignore: non_constant_identifier_names
  String _emailError = '';
  String _usernameError = '';
  String _passwordError = '';
  String _repasswordError = '';

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<RegisterViewModel>(context);
    // print(viewmodel.status);
    // ignore: non_constant_identifier_names
    void ValidatorForm() {
      setState(() {
        String email = _email.text.trim();
        String username = _username.text.trim();
        String password = _password.text.trim();
        String repassword = _repassword.text.trim();
        final bool emailValid =
            RegExp(r"^\b[A-Za-z0-9._%+-]+@gmail\.com\b").hasMatch(email);

        if (email.isEmpty) {
          _isValidEmail = true;
          _emailError = "The blank must not be left empty!";
        } else if (!emailValid) {
          _isValidEmail = true;
          _emailError = "The email is not valid!";
        } else {
          _isValidEmail = false;
        }

        if (username.isEmpty) {
          _isValidUsername = true;
          _usernameError = "Do not leave blank!";
        } else if (username.length < 4) {
          _isValidUsername = true;
          _usernameError = "At least 4 characters!";
        } else {
          _isValidUsername = false;
        }

        if (password.isEmpty) {
          _isValidPassword = true;
          _passwordError = "Do not leave blank!";
        } else if (password.length < 8) {
          _isValidPassword = true;
          _passwordError = "At least 8 characters!";
        } else {
          _isValidPassword = false;
        }

        if (password != repassword && repassword.isNotEmpty) {
          _isValidRepassword = true;
          _repasswordError = "Incorrect password!";
        } else if (repassword.isEmpty) {
          _isValidRepassword = true;
          _repasswordError = "Do not leave blank!";
        } else {
          _isValidRepassword = false;
        }

        if (!_isValidEmail &&
            !_isValidUsername &&
            !_isValidPassword &&
            !_isValidRepassword) {
          viewmodel.register(email, username, password, repassword);
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/home.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
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
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                            child: Stack(
                              children: [
                                viewmodel.status == 3 || viewmodel.status == 4
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Registration successful!',
                                              style: TextStyle(
                                                  fontWeight:
                                                      StyleGlobal.fontWeight,
                                                  fontSize: 34),
                                            ),
                                            viewmodel.status == 3
                                                ? const Text(
                                                    'You need to verify your email to complete the registration!')
                                                : const Text(''),
                                            viewmodel.status == 4
                                                ? RichText(
                                                    text: TextSpan(
                                                      text: 'Click here',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blue.shade400,
                                                          fontSize: 16),
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () => Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                PageLogin
                                                                    .routername),
                                                      children: const [
                                                        TextSpan(
                                                          text:
                                                              ' to log in!',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const Text(''),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 200,
                                                width: 150,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'lib/assets/logo_signup.png'),
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          CusTom_Form_Input(
                                            labelForm: 'Username',
                                            textController: _username,
                                            textError: _usernameError,
                                            isValid: _isValidUsername,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                          ),
                                          CusTom_Form_Input(
                                            labelForm: 'Email',
                                            textController: _email,
                                            textError: _emailError,
                                            isValid: _isValidEmail,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                          ),
                                          CusTom_Form_Input(
                                            labelForm: 'Password',
                                            textController: _password,
                                            textError: _passwordError,
                                            isValid: _isValidPassword,
                                            obs: true,
                                            isObs: true,
                                          ),
                                          const SizedBox(height: 20),
                                          CusTom_Form_Input(
                                            labelForm: 'Re-password',
                                            textController: _repassword,
                                            textError: _repasswordError,
                                            isValid: _isValidRepassword,
                                            obs: true,
                                            isObs: true,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Checkbox(
                                                fillColor: MaterialStateProperty
                                                    .resolveWith((states) {
                                                  if (!states.contains(
                                                      MaterialState.selected)) {
                                                    return Color.fromARGB(255, 25, 30, 175);
                                                  }
                                                  return null;
                                                }),
                                                value: _isChecked,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _isChecked = !_isChecked;
                                                    viewmodel.SetChecked(
                                                        _isChecked);
                                                  });
                                                },
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      'I accept',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: ' the terms and conditions',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .blue.shade400,
                                                      ),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap =
                                                                () =>
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            'App terms of use',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromARGB(255, 211, 47, 101),
                                                                            ),
                                                                          ),
                                                                          content:
                                                                              Text(
                                                                            viewmodel.dieukhoan,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          shape:
                                                                              const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(
                                                                              Radius.circular(2),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          viewmodel.status == 2
                                              ? Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: Text(
                                                    viewmodel.errorChecked,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          const SizedBox(height: 20),
                                          InkWell(
                                            onTap: ValidatorForm,
                                            child: CusTom_ButtonSubmit(
                                              textButton: 'Sign Up',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: 'Already have an account?',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              children: [
                                                TextSpan(
                                                  text: ' Log In',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.blue.shade900,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () => Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                PageLogin
                                                                    .routername),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              viewmodel.status == 1 ? const Spiner() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
