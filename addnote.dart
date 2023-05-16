import 'package:flutter/material.dart';
import 'package:practice/noteclass.dart';
import 'main.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TaskData note = TaskData();

  insertnote(context) async {
    if(formkey.currentState!.validate()){
      List<String> existingNotes = sharedPreferences.getStringList('note') ?? [];
      existingNotes.add("${title.text},${content.text}");
      await sharedPreferences.setStringList('note', existingNotes);
     title.clear();
     content.clear();
     Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Add Note',style: TextStyle(color: Colors.white,fontSize: 20))
      ),
      body: Column(
          children: [
            const SizedBox(height: 80),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: TextFormField(
                  controller: title,
                  validator: (value) {
                    if(value!.isEmpty ){
                      return "Title can't be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                  ),
                ),
              ),
            ),
             Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: TextField(
                  controller: content,
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                  ),
                ),
              ),
            MaterialButton(
              color: Colors.blueGrey,
              onPressed: (){
                insertnote(context);
              },
              child: const Text('Add Note',style: TextStyle(color: Colors.white,fontSize: 14))
            ),
            const SizedBox(height: 50),
          ],
        ),
    );
  }
}