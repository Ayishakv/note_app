import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/utils/app_sessions.dart';
import 'package:note_app/utils/color_constants.dart';
import 'package:note_app/view/notes_screen/notes_screen.dart';
import 'package:share_plus/share_plus.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({
    super.key,
    required this.titledata,
    required this.contentdata,
    this.onDelete,
    this.onEdit,
    required this.notecolor,
    required this.date,
  });
  final String titledata;
  final String contentdata;
  final String date;

  final void Function()? onDelete;
  final void Function()? onEdit;
  final Color notecolor;

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  //  final TextEditingController titlecontroller = TextEditingController();
  // final TextEditingController descriptioncontroller = TextEditingController();
  // final TextEditingController datecontroller = TextEditingController();
  //  int selectedColorIndex = 0;
  //  var notebox = Hive.box(AppSessions.NOTEBOX);

  // List notekeys =
  //     []; //we cannot directly give notebox into this list so create a initstate and give inside it
  // @override
  // void initState() {
  //   notekeys = notebox.keys.toList();
  //   setState(() {});
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesScreen(
                content: widget.contentdata,
                title: widget.titledata,
                color: widget.notecolor,
                // edit:  () {
                //   titlecontroller.text = currentnote["title"];
                //   datecontroller.text = currentnote["date"];

                //   descriptioncontroller.text = currentnote["description"];
                //   selectedColorIndex = currentnote["colorIndex"];
                //   _buildBottomSheet(context, isEdit: true, itemIndex: index);
                // },,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.notecolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.titledata,
                    style: TextStyle(
                        color: ColorConstants.mainblack,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: widget.onEdit,
                      icon: Icon(
                        Icons.edit,
                        color: ColorConstants.mainblack,
                      )),
                  IconButton(
                      onPressed: widget.onDelete,
                      icon: Icon(
                        Icons.delete,
                        color: ColorConstants.mainblack,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(widget.contentdata,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorConstants.mainblack,
                    fontSize: 20,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(widget.date,
                      style: TextStyle(
                        color: ColorConstants.mainblack,
                        fontSize: 16,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Share.share(
                            "${widget.titledata} \n${widget.contentdata} ");
                      },
                      icon: Icon(
                        Icons.share,
                        color: ColorConstants.mainblack,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
