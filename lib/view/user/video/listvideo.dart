import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharedoc/view/user/video/videoplayer.dart';
import 'package:sharedoc/widget/carditemvideo.dart';

class ListVideo extends StatefulWidget {
  const ListVideo({Key? key}) : super(key: key);

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  final Stream<QuerySnapshot> _videoStream = FirebaseFirestore.instance
      .collection('videos')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video"),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _videoStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return const Text("something went wrong");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: Text("Tidak Ada Video"));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VideoPlayer(link: data['linkVideo'])));
                          },
                          child: Container(
                              child: CardItemVideo(judul: data['judul'])));
                    }).toList(),
                  );
                }),
              ),
            );
          }),
    );
  }
}
