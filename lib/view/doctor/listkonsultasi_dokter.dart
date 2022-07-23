import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharedoc/widget/cardchatdokter.dart';

class ListKonsultasiDokter extends StatefulWidget {
  final String nama_lengkap;
  final int role;
  const ListKonsultasiDokter(
      {Key? key, required this.nama_lengkap, required this.role})
      : super(key: key);

  @override
  State<ListKonsultasiDokter> createState() => _ListKonsultasiDokterState();
}

class _ListKonsultasiDokterState extends State<ListKonsultasiDokter> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _konsulatsiStream = FirebaseFirestore.instance
        .collection('konsultasi')
        .where('status', isEqualTo: 0)
        .snapshots(includeMetadataChanges: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konsultasi Pakar"),
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
              return const Center(child: Text("Tidak Ada Transaksi"));
            }
            return Scaffold(
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
                            print(document.id);
                          },
                          child: CardChatDokter(
                              nama: data['nama_legkap'],
                              namaDokter: widget.nama_lengkap,
                              userId: data['uid'],
                              docId: document.id,
                              pertanyaan: data['pertanyaan']));
                    }).toList(),
                  );
                }),
              ),
            );
          }),
    );
  }
}
