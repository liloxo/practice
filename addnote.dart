import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice/mycolors.dart';
import 'package:practice/noteclass.dart';
import 'package:practice/textfield.dart';
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
  String dateTime = DateFormat('d MMMM').format(DateTime.now());

  insertnote(context) async {
    if(formkey.currentState!.validate()){
      //String timestamp = dateTime.toString();
      List<String> existingNotes = sharedPreferences.getStringList('note') ?? [];
      existingNotes.add("${title.text},${content.text},$dateTime.");
      await sharedPreferences.setStringList('note', existingNotes);
     title.clear();
     content.clear();
     Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(iconSize: 30, onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.arrow_back),color: AppColors.primaryColor),
              ),
              const Padding(
                padding:  EdgeInsets.only(left: 10),
                child: Text(" Add Note ", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
              ),
              ]),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(onPressed: (){insertnote(context);}, icon: const Icon(Icons.save_alt_rounded,size: 30,)),
              )
            ],
          ),
          const SizedBox(height: 15),
          CustomAddNoteFormField(
            mycontroller: title,
            autofocus: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',      
              hintStyle: TextStyle(fontSize: 25) 
            ),
            valid: (value){
              if( value == null || value.isEmpty ) {
                return "Title Can't Be Empty";
              }return null ;
            }, titleornote: true,
            ),
          CustomAddNoteFormField(
            maxLines: null,
              mycontroller: content,
              autofocus: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note'
              ), titleornote: false,
          )
        ]
      )
        )
    );
    
  }
}
