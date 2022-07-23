import 'package:flutter/material.dart';

class CardNews extends StatefulWidget {
  final String title;
  final String image;
  const CardNews({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  State<CardNews> createState() => _CardNewsState();
}

class _CardNewsState extends State<CardNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 120,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                )),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
