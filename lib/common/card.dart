import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String time;
  final String content;
  final String hashtag;
  final String imagePath;
  final int likes;
  final int comments;
  final int shares;

  const PostCard({
    super.key,
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
      margin: const EdgeInsets.all(16.0),
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
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(content),
            const SizedBox(height: 5),
            Text(
              hashtag,
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(imagePath),
            const SizedBox(height: 10),
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

  const IconWithText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
