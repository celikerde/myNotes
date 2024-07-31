import 'package:flutter/material.dart';
import 'package:mynotes/services/crud/notes_service.dart';
import 'package:mynotes/utilities/dialogs/delete_dialog.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  const NotesListView({
    Key? key,
    required this.onDelete,
    required this.notes,
  }) : super(key: key);

  final List<DatabaseNote> notes;
  final DeleteNoteCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDelete(note);
                }
              },
            ),
          );
        });
  }
}
