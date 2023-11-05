import 'package:anime_wallpaper/Screens/home.dart';
import 'package:flutter/material.dart';

import '../Screens/category_screen.dart';
import 'drawer_scr.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('AnimeInk',style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold
          )),
          bottom:    TabBar(
            indicator: BoxDecoration(shape: BoxShape.circle
            ),
            indicatorColor: const Color(0xFF273141),
            splashBorderRadius: BorderRadius.circular(50),
            
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Categories'),
              ],
            ),
        ) ,
        drawer: const DrawerScreen(),
        body: const TabBarView(children: [
          HomePage(),
          CategoryScreen(),

        ]),
      )
      );
  }
}