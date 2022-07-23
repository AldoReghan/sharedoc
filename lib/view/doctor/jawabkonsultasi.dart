import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:petanipintar/model/Jawaban.dart';
// import 'package:petanipintar/model/Pertanyaan.dart';
// import 'package:petanipintar/provider/PertanyaanProvider.dart';
import 'package:provider/provider.dart';
import 'package:sharedoc/core/entity/JawabKonsultasi.dart';
import 'package:sharedoc/core/services/konsultasi_services.dart';

class JawabKonsultasi extends StatefulWidget {
  final String userid;
  final String docId;
  final String pertanyaan;
  final String namaPakar;
  const JawabKonsultasi(
      {Key? key,
      required this.userid,
      required this.docId,
      required this.pertanyaan,
      required this.namaPakar})
      : super(key: key);

  @override
  State<JawabKonsultasi> createState() => _JawabKonsultasiState();
}

class _JawabKonsultasiState extends State<JawabKonsultasi> {
  final TextEditingController jawabanController = TextEditingController();

  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jawab Konsultasi"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Pertanyaan : "),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(widget.pertanyaan),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                      controller: jawabanController,
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1000,
                      decoration: const InputDecoration(
                          hintText: 'Jawab Konsultasi',
                          fillColor: Color(0xffF1F0F5),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      context.read<PertanyaanProvider>().jawabPertanyaan(
                          Jawaban(widget.userid, jawabanController.text,
                              DateTime.now(), widget.namaPakar),
                          1,
                          widget.docId);
                      print(widget.userid);
                      print(widget.docId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: const Center(
                          child: Text(
                        "Kirim",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
