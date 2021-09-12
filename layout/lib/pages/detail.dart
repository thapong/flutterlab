import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  //const detailPage({Key? key}) : super(key: key);
  final title, detail, imageUrl, story;
  DetailPage(this.title, this.detail, this.imageUrl, this.story);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var title, detail, imageUrl, story;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    detail = widget.detail;
    imageUrl = widget.imageUrl;
    story = widget.story;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tourism :" + title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(title,
                style: TextStyle(fontSize: 14, color: Colors.blue[800])),
            SizedBox(height: 5),
            Text(detail,
                style: TextStyle(fontSize: 14, color: Colors.blue[800])),
            SizedBox(height: 10),
            Image.network(imageUrl),
            SizedBox(height: 10),
            Text(story, style: TextStyle(fontSize: 14, color: Colors.blue[800]))
          ],
        ),
      ),
    );
  }
}
