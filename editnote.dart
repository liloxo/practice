import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice/mycolors.dart';
import 'package:practice/noteclass.dart';
import 'package:practice/textfield.dart';
import 'main.dart';

class EditNote extends StatefulWidget {
  final String title;
  final String? content;
  final int i;
  final String time;
  const EditNote({super.key, required this.title, this.content, required this.i, required this.time});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleedit = TextEditingController();
  TextEditingController contentedit = TextEditingController();
  TaskData note = TaskData();
  late int i;
  late String notetime;
  String newdateTime = DateFormat('d MMMM').format(DateTime.now());

  void editNote(context) async {
    if (formkey.currentState!.validate()) {
      List<String>? existingNotes = sharedPreferences.getStringList('note') ;
      if (existingNotes != null && i >= 0 && i < existingNotes.length) {
      existingNotes[i] = "${titleedit.text},${contentedit.text},$newdateTime";
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
    notetime = widget.time;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(iconSize: 30, onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.arrow_back),color: AppColors.primaryColor),
              )
              ]),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(onPressed: (){
                  editNote(context);
                }, icon: const Icon(Icons.check,size: 30,)),
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(notetime,style: const TextStyle(color: AppColors.grey,fontSize: 17)),
              )
            ],
          ),
          const SizedBox(height: 15),
          CustomAddNoteFormField(
            mycontroller: titleedit,
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
              mycontroller: contentedit,
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
