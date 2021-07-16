import 'package:demo_project_1/addentry_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  var entryList = [];
  var lastEntry = "";

  _DiaryPageState() {
    refreshDiary();
    FirebaseDatabase.instance.reference().child("entries").onChildAdded.listen((event) {
      refreshDiary();
    });
  }

  void refreshDiary() {
    //load all entries from Firebase DB and display them in a listview
    FirebaseDatabase.instance.reference().child("entries").once()
        .then((datasnapshot) {
      var tempEntryList = [];
      var keyList = [];
      print('Loading Successful!');
      // print(value);
      datasnapshot.value.forEach((k,v) {
        // print(k);
        // print(v);
        keyList.add(k);
        tempEntryList.add(v);
      });
      //print(tempEntryList);
      entryList = tempEntryList;
      lastEntry = keyList[keyList.length - 1].toString();
      // print(lastEntry);
      setState(() {

      });
    }).catchError((error) {
      print("Loading Unsuccessful!");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Current Recorded Entries',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 253, 208, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_img.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: entryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left:15.0,right: 15.0, top: 150.0, bottom: 150.0),
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 5),
                color: Color.fromRGBO(255, 253, 208, 1)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      "${entryList[index]['title']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${entryList[index]['date']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      "${entryList[index]['text']}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEntryPage(entryTitle: lastEntry)),
          );
        },
        child: Icon(Icons.add, color: Colors.black,),
        backgroundColor: Color.fromRGBO(255, 253, 208, 1),
      ),
    );
  }
}
