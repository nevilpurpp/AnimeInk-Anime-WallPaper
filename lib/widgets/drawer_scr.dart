import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';




class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'nevilpurpp12@gmail.com',
  );

final Uri ratingUrl = Uri.parse('https://play.google.com/store/apps/details?id=com.anime_wallpaper.fl');
 Future<void> _launchUrlRating() async {
  if (!await launchUrl(emailLaunchUri)) {
    throw Exception('Could not launch $emailLaunchUri');
  }
}

  Future<void> _launchUrlMessage() async {
  if (!await launchUrl(emailLaunchUri)) {
    throw Exception('Could not launch $emailLaunchUri');
  }
}
  @override
  Widget build(BuildContext context) {
 
    return Drawer(
      child: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView(children:  [
            const SizedBox(height: 50,),
            const SizedBox(
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
             GestureDetector(
               child: const ListTile(
                leading: Icon(Icons.info),
                title:  Text('About Us'),
                         ),
             ),
           const  Divider(),
           //message us
            GestureDetector(
              child: const ListTile(
                leading: Icon(Icons.message_outlined),
                title: Text('How can we improve?'),
                subtitle: Text('Tell us how we can improve this app?'),
              ),
              onTap:(){
                _launchUrlMessage();
              } ,
            ),
            const Divider(),
            //rate us
            GestureDetector(
              child: const ListTile(
                leading: Icon(Icons.star),
                title: Text('Rate app'),
              ),
              onTap: (){
                _launchUrlRating();
              }
            ),
            const Divider(),
            //Share our app
        GestureDetector(
          child: const ListTile(
            shape: StadiumBorder(),
                leading: Icon(Icons.share),
                title: Text('Share app'),
                subtitle: Text('Tell us how can we improve this app?', style: TextStyle(color: Colors.white24),),
              ),
        ),
            //about
            
            const Divider(),
            //Themes 
            const ListTile(
              leading: Icon(Icons.light),
              title: Text('Theme'),
            //trailing:       ,
            ),
            const Divider(),
          ]),
        ),
      ),
    );
  }
}
