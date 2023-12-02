import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_app/menu/menu.dart';
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  int currentIndex = 0;
   final iconList = <IconData>[
    Icons.travel_explore_outlined,
    Icons.explore_outlined,
    Icons.favorite_outline,
    Icons.account_circle_outlined,
  ];
  final nameList = <String>[
    'Travel',
    'Explore',
    'Favorite',
    'Profile',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  extendBody: true,
   floatingActionButton: FloatingActionButton(
    shape: CircleBorder(),
    onPressed: () {  },
    child: Icon(Icons.navigation,color: Colors.white,),
    backgroundColor: Color(0xff222428),
   ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   bottomNavigationBar: AnimatedBottomNavigationBar.builder(
    itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index],
              size: 24,
              color: isActive ? Theme.of(context).primaryColor : Colors.white
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(nameList[index],style: TextStyle(color: isActive? Theme.of(context).primaryColor : Colors.white, fontSize: 11, fontWeight: FontWeight.w400,),),
            ),
          ],
        );
      }, 
      activeIndex: currentIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      backgroundColor: Color(0xff222428),
      height: 70,
      notchMargin: 5, 
      leftCornerRadius: 10,
      rightCornerRadius: 10,
      onTap: (index) => setState(() => currentIndex = index),
      //other params
   ),

      body: <Widget>[
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        // MainMenu(),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
      ][currentIndex]
    );
  }
}


