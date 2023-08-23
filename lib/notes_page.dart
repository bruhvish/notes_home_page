import 'package:flutter/material.dart';
import 'note_edit_page.dart'; // Import the note editing page

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // List of notes (you can replace this with a database or other data source)
  List<String> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        title: Text(
          'My Notes',
          style: TextStyle(
              //fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 36.0,
              fontWeight: FontWeight.w100),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              // Implement search functionality
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.menu_open,
              color: Colors.black,
            ),
            onSelected: (result) {
              // Implement options menu functionality
            },
            itemBuilder: (BuildContext context) {
              return ['Options'].map((option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteItem(
            note: note,
            onDelete: () {
              setState(() {
                notes.removeAt(index);
              });
            },
            onEdit: () {
              _navigateToEditPage(note);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to note editing page for adding a new note
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditPage(
                note: '',
              ),
            ),
          ).then((newNote) {
            if (newNote != null) {
              setState(() {
                notes.insert(0, newNote);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditPage(String note) {}
}

class NoteItem extends StatelessWidget {
  final String note;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  NoteItem({required this.note, required this.onDelete, required this.onEdit});

  String _extractFirstLine(String text) {
    // Split the text into lines
    List<String> lines = text.split('\n');

    // Use the first line or an empty string if no lines are present
    return lines.isNotEmpty ? lines[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromARGB(0, 33, 149, 243)),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
      child: ListTile(
        title: Text(
            _extractFirstLine(note)), // Display the note content as the title
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
