import 'package:flutter/material.dart';
import 'package:practice/addnote.dart';
import 'package:practice/main.dart';
import 'package:practice/noteclass.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool longpress = false;
  TaskData note = TaskData();

  longpressconvert(){
    longpress = !longpress;
    setState(() {});
  }

  Future<void> refreshNotes() async {
    await note.getdata();
    setState(() {}); 
  }

  Future<void> saveNotesToSharedPrefs() async {
    List<String> notesData = note.notes.map((note) => "${note.title},${note.content}").toList();
    await sharedPreferences.setStringList('note', notesData);
  }
  
  deletenote(String ttl) async {
    note.notes.removeWhere((note) => note.title == ttl);
    saveNotesToSharedPrefs();
    setState(() {});
  }

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blueGrey,
        title: const Text('KeepNotes',style: TextStyle(color: Colors.white,fontSize: 20))
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
        onPressed: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddNote()));
      }),
      body: ListView.builder(
        itemCount: note.notes.length,
        itemBuilder: (context,i){
          return Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                
              },
              onLongPress: () {
                longpressconvert();
              },
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(note.notes[i].title),
                    ),
                  if (longpress) IconButton(onPressed: (){deletenote(note.notes[i].title);}, icon: const Icon(Icons.delete)) 
                  ]
                )
              ),
            )
          );
        }
      )
    );
  }
}