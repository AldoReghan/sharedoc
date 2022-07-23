import 'package:flutter/material.dart';

class CardJawab extends StatefulWidget {
  final String nama;
  final int status;
  final String pertanyaan;
  const CardJawab(
      {Key? key,
      required this.nama,
      required this.status,
      required this.pertanyaan})
      : super(key: key);

  @override
  State<CardJawab> createState() => _CardJawabState();
}

class _CardJawabState extends State<CardJawab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
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
          children: [
            // const Icon(
            //   Icons.chat,
            //   size: 40,
            // ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nama,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.pertanyaan,
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 80)),
            widget.status == 1
                ? const Text(
                    "Terjawab",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  )
                : const Text("")
          ],
        ),
      ),
    );
  }
}
