import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharedoc/view/user/konsultasi/addkonsultasi.dart';
import 'package:sharedoc/view/user/konsultasi/detailkonsultasi.dart';
import 'package:sharedoc/widget/cardchat.dart';

class ListKonsultasi extends StatefulWidget {
  final String nama_depan;
  final String nama_belakang;
  const ListKonsultasi(
      {Key? key, required this.nama_depan, required this.nama_belakang})
      : super(key: key);

  @override
  State<ListKonsultasi> createState() => _ListKonsultasiState();
}

class _ListKonsultasiState extends State<ListKonsultasi> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot> _konsulatsiStream = FirebaseFirestore.instance
        .collection('konsultasi')
        .where('uid', isEqualTo: uid)
        .snapshots(includeMetadataChanges: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("List Konsultasi"),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _konsulatsiStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return const Text("something went wrong");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: Text("Tidak Ada dokter"));
            }
            return Scaffold(
              // resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: OrientationBuilder(builder: (context, orientation) {
                  return ListView(
                    padding: const EdgeInsets.all(15),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailKonsultasiPage(
                                        nama: widget.nama_depan +
                                            " " +
                                            widget.nama_belakang,
                                        docId: document.id,
                                        uid: uid,
                                        status: data['status'],
                                        pertanyaan: data['pertanyaan'])));
                          },
                          child: CardChat(
                            nama:
                                widget.nama_depan + " " + widget.nama_belakang,
                            pertanyaan: data['pertanyaan'],
                            status: data['status'],
                          ));
                    }).toList(),
                  );
                }),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddKonsultasiPage(
                        nama_depan: widget.nama_depan,
                        nama_belakang: widget.nama_belakang,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
