import 'package:practice/main.dart';

class Note {
  String title;
  String? content;
  Note({required this.title,this.content});
}

class TaskData {
  List notes = [];

  getdata() {
    List<String>? response = sharedPreferences.getStringList('note');
    if (response != null) {
      for (String noteData in response) {
        List<String> noteDetails = noteData.split(',');
        notes.add(
          Note(
            title: noteDetails[0],
            content: noteDetails.length > 1 ? noteDetails[1] : null,
          ),
        );
      }
    }
  }
}

