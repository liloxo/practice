import 'package:practice/main.dart';

class Note {
  String title;
  String? content;
  Note({required this.title,this.content});
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
      List<String> noteDetails = noteData.split(',');
      // [title,content]
      return Note(
        title: noteDetails[0],
        content: noteDetails.length > 1 ? noteDetails[1] : null,
      );
    }).toList();
    notes = notes.reversed.toList(); // Reverse the list to display in reverse order
    }
  }

  void updateNoteByTitle(String title, String newTitle, String? newContent) {
  for (int i = 0; i < notes.length; i++) {
    if (notes[i].title == title) {
      notes[i].title = newTitle;
      notes[i].content = newContent;
      break;
    }
  }
}

  deletenote(String ttl) async {
    notes.removeWhere((note) => note.title == ttl);
    saveNotesToSharedPrefs();
  }

  Future<void> saveNotesToSharedPrefs() async {
    List<String> notesData = notes.map((note) => "${note.title},${note.content}").toList();
    await sharedPreferences.setStringList('note', notesData);
  }
}

