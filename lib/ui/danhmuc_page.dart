import 'package:flutter/material.dart';
import 'package:flutter_login/custom/app_style.dart';
import 'package:flutter_login/models/profile.dart';
import 'package:flutter_login/providers/menubar_viewmodel.dart';
import 'package:flutter_login/ui/dangkylop_page.dart';
import 'package:flutter_login/ui/login_page.dart';
import 'package:flutter_login/ui/menubar/hotrosv_menu.dart';
import 'package:flutter_login/ui/menubar/dangxuat_menu.dart';
import 'package:flutter_login/ui/menubar/taikhoan_menu.dart';
import 'package:flutter_login/ui/menubar/hocphandangky_menu.dart';
import 'package:flutter_login/ui/menubar/qrcode_menu.dart';
import 'package:flutter_login/ui/menubar/ds_hocphan_menu.dart';
import 'package:flutter_login/ui/menubar/ds_lop_menu.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageDashBoard extends StatefulWidget {
  const PageDashBoard({
    super.key,
  });
  static const routername = "/dashboard";

  @override
  State<PageDashBoard> createState() => _PageDashBoardState();
}

class _PageDashBoardState extends State<PageDashBoard> {
  // final int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    TaiKhoanMenu(),
    const HocPhanMenu(),
    const QrCodeMenu(),
    const HocPhanDangKyMenu(),
    const DanhSachLopMenu(),
    const HoTroSVMenu(),
    const DangXuatMenu(),
    
  ];

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<MenuBarViewModel>(context);

    final profile = Profile();
    if (profile.token == "") {
      return const PageLogin();
    }
    if (profile.student.mssv == "") {
      return const PageDangKyLop();
    }
    var user = profile.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh mục',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _widgetOptions[viewmodel.selected],
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 245, 241, 241),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 56, 5, 151),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipOval(
                                child: Image.network(
                                  user.avatar,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontWeight: StyleGlobal.fontWeight,
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            MenuBar(
              icon: 'profile',
              name: 'Tài khoản',
              selected: 0,
            ),
            const SizedBox(height: 10),
            MenuBar(
              icon: 'folders',
              name: 'Danh sách học phần',
              selected: 1,
            ),
            const SizedBox(height: 10),
            MenuBar(
              icon: 'scan',
              name: 'Mã QR',
              selected: 2,
            ),
            const SizedBox(height: 10),
            MenuBar(
              icon: 'contract',
              name: 'Học phần đăng ký',
              selected: 3,
            ),
            const SizedBox(height: 10),
            MenuBar(
              icon: 'presentation',
              name: 'Danh sách lớp',
              selected: 4,
            ),
            const SizedBox(height: 10),
            MenuBar(
              icon: 'contract',
              name: 'Hỗ trợ sinh viên',
              selected: 5,
            ),
            const SizedBox(height: 10),
            MenuBar(
              icon: 'logout',
              name: 'Đăng xuất',
              selected: 6,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MenuBar extends StatefulWidget {
  MenuBar({
    super.key,
    required this.icon,
    required this.name,
    required this.selected,
  });

  final String icon;
  final String name;
  int selected;

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<MenuBarViewModel>(context);
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: viewmodel.selected == widget.selected
            ? BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(10))
            : null,
        child: ListTile(
          leading: Image(
            image: AssetImage("lib/assets/icon/${widget.icon}.png"),
            width: 25,
            height: 25,
            fit: BoxFit.cover,
            //color: const Color.fromARGB(255, 0, 0, 0),
          ),
          title: Text(widget.name),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: StyleGlobal.fontWeight,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          selectedColor: Colors.white,
          selected: viewmodel.selected == widget.selected,
          onTap: () {
            viewmodel.SetSelected(widget.selected);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
