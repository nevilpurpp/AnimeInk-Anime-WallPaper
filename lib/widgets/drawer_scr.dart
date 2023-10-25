import 'package:flutter/material.dart';

import 'chip_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView(children:  [
            //theme change mode
            const ListTile(
              title: Text('AnimeInk'),
            ),
            Divider(),
             GestureDetector(
               child: const ListTile(
                title: Text('Categories'),
                         ),
                         onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryChipsWidget()
                            )
                          );
                         }
             ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.light),
              title: Text('Theme'),
              //trailing: Switch(value: value, onChanged: onChanged),
            ),
            Divider(),
          ]),
        ),
      ),
    );
  }
}
