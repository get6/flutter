import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'notes_model.dart' show Note, NotesModel, notesModel;

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("## NotesList.build()");
    return ScopedModel(
      model: notesModel,
      child: ScopedModelDescendant(
        builder: (BuildContext inContext, Widget inChild, NotesModel inModel) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                notesModel.entityBeingEdited = Note();
                notesModel.setColor(null);
                notesModel.setStackIndex(1);
              },
            ),
          );
        },
      ),
    );
  }
}
