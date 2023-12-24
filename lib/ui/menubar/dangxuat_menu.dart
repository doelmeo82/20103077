import 'package:flutter/material.dart';
import 'package:flutter_login/custom/app_style.dart';
import 'package:flutter_login/providers/login_viewmodel.dart';
import 'package:flutter_login/providers/menubar_viewmodel.dart';
import 'package:provider/provider.dart';

class DangXuatMenu extends StatelessWidget {
  const DangXuatMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  void initState() {
    super.initState();
    // Delay the showing of SnackBar until after the widget has been laid out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAlertDialog(context);
    });
  }

  void _showAlertDialog(BuildContext context) {
    final viewmodel = Provider.of<MenuBarViewModel>(context, listen: false);
    final dangxuat = Provider.of<LoginViewModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Đăng xuất',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Bạn có chắc chắn đăng xuất không?',
            style: StyleGlobal.h3,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                viewmodel.SetSelected(0);
                // Navigator.of(context).pop();
                // Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                'Cancel',
                style: StyleGlobal.h4,
              ),
            ),
            ElevatedButton(
              child: const Text(
                'OK',
                style: StyleGlobal.h4,
              ),
              onPressed: () async {
                dangxuat.logout();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
                viewmodel.SetSelected(0);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
