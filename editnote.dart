import 'package:flutter/material.dart';
import 'package:practice/noteclass.dart';
import 'main.dart';

class EditNote extends StatefulWidget {
  final String title;
  final String? content;
  final int i;
  const EditNote({super.key, required this.title, this.content, required this.i});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleedit = TextEditingController();
  TextEditingController contentedit = TextEditingController();
  TaskData note = TaskData();
  late int i;

  void editNote(context) async {
    if (formkey.currentState!.validate()) {
      List<String>? existingNotes = sharedPreferences.getStringList('note') ;
      if (existingNotes != null && i >= 0 && i < existingNotes.length) {
      existingNotes[i] = "${titleedit.text},${contentedit.text}";
      await sharedPreferences.setStringList('note', existingNotes);
    }
      Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
    }
  }

  @override
  void initState() {
    titleedit.text = widget.title;
    contentedit.text = widget.content!;
    i = widget.i;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blueGrey,
        title: const Text('Edit Note',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 80),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: TextFormField(
                  controller: titleedit,
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
                  controller: contentedit,
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
            const SizedBox(height: 25),
            MaterialButton(
                color: Colors.blueGrey,
                onPressed: (){
                  editNote(context);
                },
                child: const Text('Edit',style: TextStyle(fontSize: 17.5,color: Colors.white))
            )
        ]
      )
    );
  }
}
