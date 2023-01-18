import 'package:flutter/material.dart';
import 'package:news_app_client/widgets/top_bar.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context),
      body: const Placeholder(),
    );
  }
}
