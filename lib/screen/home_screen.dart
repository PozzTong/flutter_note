import 'package:flutter/material.dart';
import 'package:flutter_app_vscode/global/style/style_widget.dart';
import 'package:flutter_app_vscode/model/note_model.dart';
import 'package:flutter_app_vscode/screen/add_note.dart';
import 'package:flutter_app_vscode/screen/drawer/drawer_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(
        child: DrawerScreen(),
      ),
      appBar: AppBar(
        title: const Text("Kepp Note"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => buildNoteCard(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNoteScreen(),
                  ));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget buildNoteCard({NoteModel? note}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello", style: noteTitle),
                      Text(
                        "hello",
                        style: notebody,
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMd()
                            .add_Hm()
                            .format(DateTime.now()),
                        style: notebody,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello",
                        style: noteCategory,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          maxRadius: 9,
                          backgroundColor: HexColor('#f1c232'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
