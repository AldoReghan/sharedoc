import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sharedoc/widget/cardjawab.dart';

class DetailKonsultasiPage extends StatefulWidget {
  final String nama;
  final String pertanyaan;
  final String uid;
  final String docId;
  final int status;
  const DetailKonsultasiPage({
    Key? key,
    required this.nama,
    required this.pertanyaan,
    required this.uid,
    required this.docId,
    required this.status,
  }) : super(key: key);

  @override
  _DetailKonsultasiPageState createState() => _DetailKonsultasiPageState();
}

class _DetailKonsultasiPageState extends State<DetailKonsultasiPage> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  String nama_pakar = "";
  String jawaban = "";

  getJawab() async {
    var collection = FirebaseFirestore.instance.collection('jawabKonsultasi');
    var docSnapshot =
        await collection.where('docId', isEqualTo: widget.docId).get();
    if (docSnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> data =
          docSnapshot.docs.single;
      var valueJawaban = data['jawaban'];
      var valuePakar = data['nama_dokter'];
      setState(() {
        nama_pakar = valuePakar;
        jawaban = valueJawaban;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getJawab();
  }

  @override
  Widget build(BuildContext context) {
    print("ini jawaban " + jawaban);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Konsultasi"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardJawab(
                    nama: widget.nama,
                    status: 0,
                    pertanyaan: widget.pertanyaan),
              ),
              widget.status == 1
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardJawab(
                          nama: nama_pakar, status: 0, pertanyaan: jawaban),
                    )
                  : const Text("")
            ],
          ),
        ),
      ),
    );
  }
}
