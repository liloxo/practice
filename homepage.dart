import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:practice/addnote.dart';
import 'package:practice/editnote.dart';
import 'package:practice/mycolors.dart';
import 'package:practice/noteclass.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskData note = TaskData();

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
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddNote()));
      }),
      body: Column(
          children: [
            const SizedBox(height: 25),
            Container(
              color: AppColors.primaryColor,
              height: 170,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 70),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('KeepNotes',style: TextStyle(color: Colors.white,fontSize: 27,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10),
                        Text("${note.notes.length} notes",style: const TextStyle(color: AppColors.white,fontSize: 17.5)),
                      ]
                    )
                  ]
                )
              )
            ),
            Expanded(
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top:35),
                  itemCount: note.notes.length,
                  itemBuilder: (context,i){
                    int reversedIndex = note.notes.length - i-1;
                    return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(), 
                          children: [
                           SlidableAction(
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.white,
                            onPressed: (context){
                            note.deletenote(note.notes[i].title,note.notes[i].content);
                            setState(() {});
                           },icon: Icons.delete),
                           SlidableAction(
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: AppColors.secondaryColor,
                            foregroundColor: AppColors.white,
                            onPressed: (context){
                            Navigator.of(context).push(MaterialPageRoute(builder: ((context) => EditNote(
                             title: note.notes[i].title,
                             content: note.notes[i].content,
                             i: reversedIndex,
                            ))));
                           },icon: Icons.edit,)
                          ]
                        ),
                        child: Container(
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
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text(note.notes[i].title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),maxLines: 1),
                                        )
                                      ]
                                    ),
                                    const SizedBox(height: 7),
                                    Row(children: [
                                     Text(note.notes[i].dateTime,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.grey)),
                                    ])
                                  ],
                                ),
                              )
                            )
                          )
                        )
                    );
                  }
                ),
              ),
            ),
          ],
      )
    );
  }
}
