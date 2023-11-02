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
          height: double.infinity,
          width: double.infinity,
          child: ListView(children:  const [
            SizedBox(height: 50,),
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/icon10242.jpeg'),
                    radius: 80,
                    ),
                    Text('AnimeInk-WallPaper App',
                     style: TextStyle(
                      fontSize: 25, 
                      fontWeight: FontWeight.bold
                      ))
                ],
              ),
            ),
            const Divider(),
             ListTile(
              leading: Icon(Icons.info),
              title:  Text('About Us'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.message_outlined),
              title: Text('How can we improve?'),
              subtitle: Text('Tell us how we can improve this app?'),
            ),
            Divider(),
            //rate us
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate app'),
            ),
            Divider(),
            //Share our app
        ListTile(
              leading: Icon(Icons.share),
              title: Text('Share app'),
              subtitle: Text('Tell us how can we improve this app?'),
            ),
            //about
            
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
