import 'package:practice/main.dart';

class Note {
  String title;
  String? content;
  String dateTime;
  Note({required this.title,this.content,required this.dateTime});
}

class TaskData {
  List notes = [];

  getdata() {
    // retrieve the stored note data from SharedPreferences
    List<String>? response = sharedPreferences.getStringList('note');
    // check if the response is not null 
    if (response != null) {
      // iterate over each string in the response list. In each iteration, the current string is assigned to the noteData variable
    notes = response.map((noteData) {
      // title,content
      List<String>? noteDetails = noteData.split(',');
      // [title,content]
      return Note(
        title: noteDetails[0],
        content: noteDetails.length > 1 ? noteDetails[1] : null,
        dateTime: noteDetails[2],
      );
    }).toList();
    notes = notes.reversed.toList(); // reverse the list to display in reverse order
    }
  }

  deletenote(String ttl,String cnt) async {
    notes.removeWhere((note) => note.title == ttl && note.content == cnt);
    saveNotesToSharedPrefs();
  }

  Future<void> saveNotesToSharedPrefs() async {
    List<String> notesData = notes.map((note) => "${note.title},${note.content}").toList();
    await sharedPreferences.setStringList('note', notesData);
  }
}
