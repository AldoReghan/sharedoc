import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedoc/core/entity/JawabKonsultasi.dart';
import 'package:sharedoc/core/entity/Konsultasi.dart';

class PertanyaanProvider with ChangeNotifier {
  CollectionReference konsultasi =
      FirebaseFirestore.instance.collection('konsultasi');

  CollectionReference jawabKonsultasi =
      FirebaseFirestore.instance.collection('jawabKonsultasi');

  Future<String?> addPertanyaan(Konsultasi pertanyaan) async {
    konsultasi.add({
      'uid': pertanyaan.uid,
      'nama_legkap': pertanyaan.namaLengkap,
      'pertanyaan': pertanyaan.pertanyaan,
      'status': pertanyaan.status,
      'count': 1
    });
    return null;
  }

  Future<String?> jawabPertanyaan(
      Jawaban jawaban, int status, String docId) async {
    jawabKonsultasi.add({
      'docId': docId,
      'nama_dokter': jawaban.namaDokter,
      'jawaban': jawaban.jawaban,
      'tgl_jawaban': jawaban.tgljawab
    });

    konsultasi.doc(docId).update({
      'status': status,
    });
    return null;
  }
}
