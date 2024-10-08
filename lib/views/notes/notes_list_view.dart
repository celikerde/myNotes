import 'package:flutter/material.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
//import 'package:mynotes/services/crud/notes_service.dart';
import 'package:mynotes/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  const NotesListView({
    Key? key,
    required this.onDelete,
    required this.onTap,
    required this.notes,
  }) : super(key: key);

  final Iterable<CloudNote> notes;
  final NoteCallback onDelete;
  final NoteCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes.elementAt(index);
          return ListTile(
            onTap: () {
              onTap(note);
            },
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
