import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NotePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _showDeleteIcon = false;
  String? _noteToDelete;

  void _toggleDeleteIcon(String? noteId) {
    setState(() {
      _showDeleteIcon = !_showDeleteIcon;
      _noteToDelete = noteId;
    });
  }

  void _deleteNote() async {
    if (_noteToDelete != null) {
      await _firestore.collection('notes').doc(_noteToDelete).delete();
      _toggleDeleteIcon(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontSize: 30)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notes available'));
          }

          final notes = snapshot.data!.docs;

          return Stack(
            children: [
              ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return GestureDetector(
                    onLongPress: () => _toggleDeleteIcon(note.id),
                    onTap: () {
                      if (_showDeleteIcon) {
                        _toggleDeleteIcon(null);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotePage(noteId: note.id),
                          ),
                        );
                      }
                    },
                    child: ListTile(
                      title: Text(note['title']),
                      subtitle: Text(note['content']),
                    ),
                  );
                },
              ),
              if (_showDeleteIcon)
                Positioned(
                  bottom: 16,
                  left: MediaQuery.of(context).size.width / 2 - 28,
                  child: FloatingActionButton(
                    onPressed: _deleteNote,
                    child: Icon(Icons.delete),
                    backgroundColor: Colors.red,
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
