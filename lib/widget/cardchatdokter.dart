import 'package:flutter/material.dart';
import 'package:sharedoc/view/doctor/jawabkonsultasi.dart';

class CardChatDokter extends StatelessWidget {
  final String nama;
  final String namaDokter;
  final String userId;
  final String docId;
  final String pertanyaan;

  const CardChatDokter(
      {Key? key,
      required this.nama,
      required this.userId,
      required this.docId,
      required this.pertanyaan,
      required this.namaDokter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 150,
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.question_mark,
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
                        overflow: TextOverflow.visible,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JawabKonsultasi(
                              userid: userId,
                              docId: docId,
                              namaPakar: namaDokter,
                              pertanyaan: pertanyaan,
                            )));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Beri Jawaban",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
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
