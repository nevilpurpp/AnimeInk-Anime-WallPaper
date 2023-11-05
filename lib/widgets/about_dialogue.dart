import 'package:flutter/material.dart';

class AboutDialogue extends StatelessWidget {
   final String title;
  final String content;
  final VoidCallback onClose;
  const AboutDialogue({
    Key? key,
    required this.title,
    required this.content,
    required this.onClose,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            SizedBox(height: 8),
            Text(content),
            SizedBox(height: 16),
            TextButton(
              onPressed: onClose,
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}