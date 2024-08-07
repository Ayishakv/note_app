import 'package:flutter/material.dart';
import 'package:note_app/utils/color_constants.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({
    super.key,
    required this.title,
    required this.content,
    required this.color,
    this.edit,
  });
  final String title;
  final String content;
  final Color color;
  final void Function()? edit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainblack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop,
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.mainwhite,
            )),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "asset/images/80950_alt.png",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                color: color,
              ),
            ),
          ),
          Positioned(
              // top: 130,
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 130),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: ColorConstants.mainblack,
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // height: 500,
                    width: 300,
                    child: Text(content,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: ColorConstants.mainblack,
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
