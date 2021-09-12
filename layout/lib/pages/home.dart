import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thailand Tourism"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              //  var data = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Mybox(
                      snapshot.data[index]['title'],
                      snapshot.data[index]['detail'],
                      snapshot.data[index]['imageUrl'],
                      snapshot.data[index]['story']);
                },
                itemCount: snapshot.data.length,
              );
            },
            future: getData(),
            //   DefaultAssetBundle.of(context).loadString('asset/data.json'),
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page), label: "Contact"),
        ],
        onTap: (index) {
          setState(() {
            print(index);
          });
        },
      ),
    );
  }

  Widget Mybox(
      String boxTitle, String boxDetail, String imageUrl, String story) {
    var _title, _detail, _imageUrl, _story;
    _title = boxTitle;
    _detail = boxDetail;
    _imageUrl = imageUrl;
    _story = story;
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(10),
      // color: Colors.blue[50],
      height: 155,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(3, 3),
              blurRadius: 3,
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            boxTitle,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            boxDetail,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          SizedBox(height: 5),
          TextButton(
              onPressed: () {
                print("Next Page");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(_title, _detail, _imageUrl, _story)));
              },
              child: Text("Read more...",
                  style: TextStyle(fontSize: 14, color: Colors.lightBlue[200])))
        ],
      ),
    );
  }

  Future getData() async {
    //https://raw.githubusercontent.com/thapong/flutterlab/main/asset/data.json
    var url = Uri.https('raw.githubusercontent.com',
        '/thapong/flutterlab/main/asset/data.json');
    var response = await http.get(url);
    print(url);
    var result = json.decode(response.body);
    print(response.body);
    return result;
  }
}
