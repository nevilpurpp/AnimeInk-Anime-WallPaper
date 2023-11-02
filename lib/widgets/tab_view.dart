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
          title: const Text('AnimeInk'),
          bottom:   TabBar(
            indicator: BoxDecoration(shape: BoxShape.circle
            ),
            indicatorColor: Color.fromARGB(255, 54, 113, 152),
              tabs: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Tab(text: 'Home')),
                Tab(text: 'Categories'),
              ],
            ),
        ) ,
        drawer: const DrawerScreen(),
        body: TabBarView(children: [
          HomePage(),
          CategoryScreen(),

        ]),
      )
      );
  }
}