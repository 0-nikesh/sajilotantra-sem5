import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SocialMediaUI(),
    );
  }
}

class SocialMediaUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "SocialApp",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Let's share what going...",
                prefixIcon: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          PostCard(
            username: "Mr_Handsome",
            time: "June 9, 2024, 7:52 A.M",
            content: "Corruption and Bribery at License Office",
            hashtag: "#Problems",
            imagePath: 'assets/corruption.png',
            likes: 12,
            comments: 12,
            shares: 12,
          ),
          PostCard(
            username: "Shyame",
            time: "June 9, 2024, 7:52 A.M",
            content: "License Nikalni Procedure K ho?",
            hashtag: "#Query",
            imagePath: 'assets/license_procedure.png',
            likes: 8,
            comments: 4,
            shares: 3,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String time;
  final String content;
  final String hashtag;
  final String imagePath;
  final int likes;
  final int comments;
  final int shares;

  PostCard({
    required this.username,
    required this.time,
    required this.content,
    required this.hashtag,
    required this.imagePath,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(content),
            SizedBox(height: 5),
            Text(
              hashtag,
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Image.asset(imagePath),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconWithText(icon: Icons.thumb_up, text: likes.toString()),
                IconWithText(icon: Icons.comment, text: comments.toString()),
                IconWithText(icon: Icons.share, text: shares.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;

  IconWithText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        SizedBox(width: 5),
        Text(text, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
