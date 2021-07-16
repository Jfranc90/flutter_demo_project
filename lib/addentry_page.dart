import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEntryPage extends StatefulWidget {
  final String entryTitle;

  const AddEntryPage({Key? key, required this.entryTitle}) : super(key: key);

  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  var titleController = TextEditingController();
  var textController = TextEditingController();
  var now = new DateTime.now();
  var formatter = new DateFormat('yMd');
  var newEntryTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'New Entry Form',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 253, 208, 1),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_img.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 300.0,
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                  child:
                  TextField(
                    controller: titleController,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(255, 253, 208, 1),
                      border: OutlineInputBorder(),
                      labelText: 'Entry title: ',
                    ),
                  ),
                ),
                Container(
                  width: 300.0,
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                  child:
                  TextField(
                    controller: textController,
                    obscureText: false,
                    maxLines: 10,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(255, 253, 208, 1),
                      border: OutlineInputBorder(),
                      labelText: 'Write your thoughts',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: ElevatedButton(
                    child: Text(
                        "Add entry to diary"
                    ),
                    onPressed: (){
                      String formattedDate = formatter.format(now);
                      newEntryTitle = getNewEntryTitle();
                      print(newEntryTitle);
                      FirebaseDatabase.instance.reference().child(newEntryTitle).set(
                        {
                          "date":formattedDate,
                          "title":titleController.text,
                          "text":textController.text,
                        }
                      ).then((value) {
                        print("New entry added!");
                        Navigator.pop(context);
                      }).catchError((onError){
                        print("Failed to add new entry.");
                        print(onError);
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getNewEntryTitle() {
    var entrySplit = widget.entryTitle.split("y");
    entrySplit[0] = "entry";
    entrySplit[1] = (int.parse(entrySplit[1]) + 1).toString();
    var temp = "entries/" + entrySplit[0] + entrySplit[1];
    return temp;
  }
}
