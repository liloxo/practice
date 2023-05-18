import 'package:flutter/material.dart';
import 'package:practice/addnote.dart';
import 'package:practice/editnote.dart';
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

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text('KeepNotes',style: TextStyle(color: Colors.white,fontSize: 20)),
        leading: longpress 
        ? IconButton(onPressed: (){longpressconvert();}, icon: const Icon(Icons.arrow_back))
        : null
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
        onPressed: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddNote()));
      }),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: note.notes.length,
          itemBuilder: (context,i){
            int reversedIndex = note.notes.length - i-1;
            return Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => EditNote(
                   title: note.notes[i].title,
                   content: note.notes[i].content,
                   i: reversedIndex,
                  ))));
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
                        child: Text(note.notes[i].title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                      ),
                    if (longpress) IconButton(onPressed: (){
                      note.deletenote(note.notes[i].title);
                      setState(() {});
                      }, icon: const Icon(Icons.delete_outline,color: Colors.red,)) 
                    ]
                  )
                ),
              )
            );
          }
        ),
      )
    );
  }
}
