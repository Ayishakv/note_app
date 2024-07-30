import 'package:flutter/material.dart';

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
  int selectedColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainblack,
      body: SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) => NotesCard(
                  notecolor: Dummydb
                      .notescolor[Dummydb.notesList[index]["colorIndex"]],
                  onDelete: () {
                    Dummydb.notesList.removeAt(index);
                    setState(() {});
                  },
                  onEdit: () {
                    titlecontroller.text =
                        Dummydb.notesList[index]["title"].toString();
                    descriptioncontroller.text =
                        Dummydb.notesList[index]["description"].toString();
                    selectedColorIndex = Dummydb.notesList[index]["colorIndex"];
                    _buildBottomSheet(context, isEdit: true, itemIndex: index);
                  },
                  titledata: Dummydb.notesList[index]["title"].toString(),
                  contentdata:
                      Dummydb.notesList[index]["description"].toString(),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
            itemCount: Dummydb.notesList.length),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: ColorConstants.lightblue,
        onPressed: () {
          descriptioncontroller.clear(); //to clear value after entering once
          titlecontroller.clear();
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
                decoration: InputDecoration(
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
                            ? Dummydb.notesList[itemIndex!] = {
                                "title": titlecontroller.text,
                                "description": descriptioncontroller.text,
                                "colorIndex": selectedColorIndex
                              }
                            : Dummydb.notesList.add({
                                "title": titlecontroller.text,
                                "description": descriptioncontroller.text,
                                "colorIndex": selectedColorIndex
                              });
                        Navigator.pop(context);

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
