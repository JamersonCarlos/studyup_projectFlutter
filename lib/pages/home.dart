import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void function(int) {
      print(int);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 10,
          backgroundColor: const Color(0xFF03045E),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          leading: const Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
            size: 50,
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          title: const Text(
            "Jamerson Carlos",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset('assets/img/icon_config.svg'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      //   child: WaterDropNavBar(
      //     selectedIndex: _selectedIndex,
      //     backgroundColor: Color(0xFF03045E),
      //     waterDropColor: Colors.white,
      //     bottomPadding: 20,
      //     onItemSelected: (index) {
      //       setState(() {
      //         _selectedIndex = index;
      //       });
      //     },
      //     barItems: [
      //       BarItem(
      //         filledIcon: FontAwesomeIcons.calendarDays,
      //         outlinedIcon: FontAwesomeIcons.calendarDay,
      //       ),
      //       BarItem(
      //         filledIcon: Icons.list_alt,
      //         outlinedIcon: Icons.list_alt_outlined,
      //       ),
      //       BarItem(
      //           filledIcon: FontAwesomeIcons.clipboardUser,
      //           outlinedIcon: FontAwesomeIcons.clipboard)
      //     ],
      //   ),
      // ),
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(FontAwesomeIcons.calendarDays, color: Color(0xFF03045E)),
          Icon(FontAwesomeIcons.add, color: Color(0xFF03045E)),
          Icon(FontAwesomeIcons.clipboardList, color: Color(0xFF03045E)),
        ],
        inactiveIcons: const [
          Icon(
            FontAwesomeIcons.calendarDays,
            color: Colors.white,
          ),
          Icon(
            Icons.calendar_month_rounded,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.clipboardUser,
            color: Colors.white,
          ),
        ],
        color: Color(0xFF03045E),
        circleColor: Colors.white,
        height: 60,
        circleWidth: 60,
        activeIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        // tabCurve: ,
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Color(0xFF03045E),
        circleShadowColor: Color(0xFF03045E),
        elevation: 10,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
      ),
    );
  }
}
