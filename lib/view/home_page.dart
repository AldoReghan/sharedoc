import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedoc/core/services/news_servicces.dart';
import 'package:sharedoc/view/doctor/listkonsultasi_dokter.dart';
import 'package:sharedoc/view/user/konsultasi/listkonsultasi_user.dart';
import 'package:sharedoc/view/user/video/listvideo.dart';
import 'package:sharedoc/widget/cardmenu.dart';
import 'package:sharedoc/widget/cardnews.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  String nama_depan = "";
  String nama_belakang = "";
  int role = 0;

  getJawab() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.where('uid', isEqualTo: uid).get();
    if (docSnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> data =
          docSnapshot.docs.single;
      setState(() {
        nama_depan = data['nama_depan'];
        nama_belakang = data['nama_belakang'];
        role = data['role'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJawab();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots(includeMetadataChanges: true);

    final NewsServices newsServices =
        Provider.of<NewsServices>(context, listen: true);
    newsServices.getnews(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.person,
                    size: 55,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Selamat Datang, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          nama_depan + " " + nama_belakang,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (role == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListKonsultasi(
                                      nama_depan: nama_depan,
                                      nama_belakang: nama_belakang,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListKonsultasiDokter(
                                    nama_lengkap:
                                        nama_depan + " " + nama_belakang,
                                    role: role)));
                      }
                    },
                    child: const CardMenu(
                      icon: Icons.chat,
                      title: "Konsultasi",
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListVideo()));
                    },
                    child: const CardMenu(
                      icon: Icons.play_circle,
                      title: "Video",
                    ),
                  ),
                  const Spacer(),
                  const CardMenu(
                    icon: Icons.info,
                    title: "Tentang",
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
                  Text(
                    "News",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text("Show All",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ],
              ),
            ),
            newsServices.listnews != null
                ? Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: newsServices.listnews.length,
                      itemBuilder: (context, index) {
                        final datanews = newsServices.listnews[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CardNews(
                                title: datanews.title,
                                // ignore: prefer_if_null_operators, unnecessary_null_comparison
                                image: datanews.urlToImage == null
                                    ? "https://shahpourpouyan.com/wp-content/uploads/2018/10/orionthemes-placeholder-image-1.png"
                                    : datanews.urlToImage));
                      },
                    ),
                  )
                : const Center(
                    child: Text("Tidak ada berita"),
                  )
          ],
        ),
      ),
    );
  }
}
