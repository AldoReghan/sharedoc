import 'package:flutter/material.dart';

class CardChat extends StatelessWidget {
  final String nama;
  final int status;
  final String pertanyaan;

  const CardChat(
      {Key? key,
      required this.nama,
      required this.status,
      required this.pertanyaan})
      : super(key: key);

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
              Icons.person,
              size: 40,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    pertanyaan,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 80)),
            status == 1
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
