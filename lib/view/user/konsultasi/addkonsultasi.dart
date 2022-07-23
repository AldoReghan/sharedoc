import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:sharedoc/core/entity/Konsultasi.dart';
import 'package:sharedoc/core/services/konsultasi_services.dart';

class AddKonsultasiPage extends StatefulWidget {
  final String nama_depan;
  final String nama_belakang;
  const AddKonsultasiPage(
      {Key? key, required this.nama_depan, required this.nama_belakang})
      : super(key: key);

  @override
  _AddKonsultasiPageState createState() => _AddKonsultasiPageState();
}

class _AddKonsultasiPageState extends State<AddKonsultasiPage> {
  final TextEditingController pertanyaanController = TextEditingController();

  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajukan Pertanyaan"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _key,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                    controller: pertanyaanController,
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: 'Ajukan pertanyaan',
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
                    context.read<PertanyaanProvider>().addPertanyaan(Konsultasi(
                        widget.nama_depan + widget.nama_belakang,
                        uid,
                        pertanyaanController.text,
                        0,
                        1));
                    // print(widget.nama_lengkap);
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
    );
  }
}
