import 'package:flutter/material.dart';
import 'package:note_app/utils/color_constants.dart';
import 'package:note_app/view/notes_screen/notes_screen.dart';
import 'package:share_plus/share_plus.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    super.key,
    required this.titledata,
    required this.contentdata,
    this.onDelete,
    this.onEdit,
    required this.notecolor,
  });
  final String titledata;
  final String contentdata;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final Color notecolor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesScreen(),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: notecolor,
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
                    titledata,
                    style: TextStyle(
                        color: ColorConstants.mainblack,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: onEdit,
                      icon: Icon(
                        Icons.edit,
                        color: ColorConstants.mainblack,
                      )),
                  IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete,
                        color: ColorConstants.mainblack,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(contentdata,
                  style: TextStyle(
                    color: ColorConstants.mainblack,
                    fontSize: 20,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text("Tue, Feb 20, 2024",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorConstants.mainblack,
                        fontSize: 16,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Share.share("$titledata \n$contentdata ");
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
