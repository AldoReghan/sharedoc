import 'package:flutter/material.dart';

class CardItemVideo extends StatelessWidget {
  final String judul;
  const CardItemVideo({Key? key, required this.judul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.play_circle,
              size: 60,
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(right: 13.0),
                child: Text(
                  judul,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Roboto',
                    color: Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
