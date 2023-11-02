import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




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
          child: ListView(children: const  [
            
             ListTile(
              title: Text('AnimeInk'),
            ),
            Divider(),
            //rate us
            //Share our app
       
            Divider(),
            //about
             ListTile(
              leading: Icon(Icons.info),
              title:  Text('About Us'),
            ),
            Divider(),
            //Themes 
            ListTile(
              leading: Icon(Icons.light),
              title: Text('Theme'),
            //trailing:       ,
            ),
            Divider(),
          ]),
        ),
      ),
    );
  }
}
