import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note_app/utils/app_sessions.dart';

import 'package:note_app/utils/color_constants.dart';
import 'package:note_app/view/dummydb.dart';
import 'package:note_app/view/global_widget/notes_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  int selectedColorIndex = 0;
  var notebox = Hive.box(AppSessions.NOTEBOX);

  List notekeys =
      []; //we cannot directly give notebox into this list so create a initstate and give inside it
  @override
  void initState() {
    notekeys = notebox.keys.toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainblack,
      body: SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              //hive implement
              var currentnote = notebox.get(notekeys[index]);
              return NotesCard(
                date: currentnote["date"],
                notecolor: Dummydb.notescolor[currentnote["colorIndex"]],
                titledata: currentnote["title"],
                contentdata: currentnote["description"],
                //to delete
                onDelete: () {
                  notebox.delete(notekeys[index]);
                  notekeys = notebox.keys.toList();
                  setState(() {});
                },
                //to edit
                onEdit: () {
                  titlecontroller.text = currentnote["title"];
                  datecontroller.text = currentnote["date"];

                  descriptioncontroller.text = currentnote["description"];
                  selectedColorIndex = currentnote["colorIndex"];
                  _buildBottomSheet(context, isEdit: true, itemIndex: index);
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
            itemCount: notekeys.length),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: ColorConstants.lightblue,
        onPressed: () {
          descriptioncontroller.clear(); //to clear value after entering once
          titlecontroller.clear();
          datecontroller.clear();
          selectedColorIndex = 0;
          _buildBottomSheet(context);
        },
      ),
    );
  }

  Future<dynamic> _buildBottomSheet(BuildContext context,
      {bool isEdit = false, int? itemIndex}) {
    return showModalBottomSheet(
      backgroundColor: ColorConstants.maingrey,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                    hintText: "Title",
                    fillColor: ColorConstants.lightblue,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptioncontroller,
                decoration: InputDecoration(
                    hintText: "Description",
                    fillColor: ColorConstants.lightblue,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: datecontroller,
                readOnly: true, //if true cannot type into the textfield
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          var selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2024),
                              lastDate: DateTime.now());
                          if (selectedDate != null) {
                            datecontroller.text =
                                DateFormat("dd MMMM y").format(selectedDate!);
                          }
                        },
                        icon: Icon(Icons.calendar_month_outlined)),
                    hintText: "Date",
                    fillColor: ColorConstants.lightblue,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 20,
              ),
              //build color section
              StatefulBuilder(
                builder: (context, setState) => Row(
                  children: List.generate(
                    Dummydb.notescolor.length,
                    (index) => Expanded(
                      child: InkWell(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: selectedColorIndex == index
                                  ? Border.all(
                                      width: 4, color: ColorConstants.mainwhite)
                                  : null,
                              borderRadius: BorderRadius.circular(10),
                              color: Dummydb.notescolor[index]),
                        ),
                        onTap: () {
                          selectedColorIndex = index;
                          setState(
                            () {},
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                            color: ColorConstants.mainblack,
                            fontSize: 16,
                          ))),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)))),
                      onPressed: () {
                        isEdit
                            ? notebox.put(notekeys[itemIndex!], {
                                "title": titlecontroller.text,
                                "description": descriptioncontroller.text,
                                "colorIndex": selectedColorIndex,
                                "date": datecontroller.text,
                              })
                            //to add new note to hive storage
                            : notebox.add({
                                "title": titlecontroller.text,
                                "description": descriptioncontroller.text,
                                "colorIndex": selectedColorIndex,
                                "date": datecontroller.text,
                              });
                        Navigator.pop(context);
                        notekeys = notebox.keys
                            .toList(); //to update the keys list after adding a note
                        setState(() {});
                      },
                      child: Text(isEdit ? "Update" : "Save",
                          style: TextStyle(
                            color: ColorConstants.mainblack,
                            fontSize: 16,
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
