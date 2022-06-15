import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/firebase_controller.dart';
import 'package:chat_app/pages/chat_list.dart';
import 'package:chat_app/pages/how_it_works_page.dart';
import 'package:chat_app/pages/user_statistics.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/Profile_page.dart';
import '../pages/expression_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> pagetitle = ValueNotifier("Messages");

  final pages = [
    const ContactsList(),
    const ExpressionPage(),
    const ProfilePage(),
    const HowItWorksPage(),
    const UserStatistics()
  ];

  final title = const [
    "Messages",
    "Emotive Selector",
    "Profile",
    "How it works",
    "User Statistics"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              Get.put(ExpressionThemeController()).getPrimaryColor(),
          elevation: 0,
          title: ValueListenableBuilder(
            valueListenable: pagetitle,
            builder: (BuildContext context, String value, _) {
              return Text(
                pagetitle.value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Get.put(ExpressionThemeController()).getTextColor()),
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: (() {
                    Get.put(FireBaseController()).trySingOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
                  icon: const Icon(Icons.exit_to_app)),
            ),
          ]),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onPageSelected: _on_Navigation_Selected,
      ),
    );
  }

  void _on_Navigation_Selected(index) {
    pagetitle.value = title[index];
    pageIndex.value = index;
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onPageSelected})
      : super(key: key);

  final ValueChanged<int> onPageSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void HandleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onPageSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
              color: Get.put(ExpressionThemeController()).getPrimaryColor()),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  label: "Messages",
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  index: 0,
                  isSelected: (selectedIndex == 0),
                  onTap: HandleItemSelected,
                ),
                _NavigationBarItem(
                  label: "Emotive Selector",
                  icon: CupertinoIcons.heart,
                  index: 1,
                  isSelected: (selectedIndex == 1),
                  onTap: HandleItemSelected,
                ),
                /*const Padding(
                  padding: EdgeInsets.all(9),
                  child:
                      Action_Button(color: AppColors.accent, icon: Icons.add),
                ),*/
                _NavigationBarItem(
                  label: "Profile",
                  icon: CupertinoIcons.profile_circled,
                  index: 2,
                  isSelected: (selectedIndex == 2),
                  onTap: HandleItemSelected,
                ),
                _NavigationBarItem(
                  label: "Statistics",
                  icon: CupertinoIcons.graph_circle,
                  index: 4,
                  isSelected: (selectedIndex == 4),
                  onTap: HandleItemSelected,
                ),
                _NavigationBarItem(
                  label: "How it works",
                  icon: CupertinoIcons.question_circle,
                  index: 3,
                  isSelected: (selectedIndex == 3),
                  onTap: HandleItemSelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.index,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);

  final String label;
  final IconData icon;
  final int index;
  final ValueChanged<int> onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (() {
        onTap(index);
      }),
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? Get.put(ExpressionThemeController()).getTertiaryColor()
                  : const Color.fromARGB(173, 255, 255, 255),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(label,
                style: isSelected
                    ? const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      )
                    : const TextStyle(
                        fontSize: 11,
                      ))
          ],
        ),
      ),
    );
  }
}
