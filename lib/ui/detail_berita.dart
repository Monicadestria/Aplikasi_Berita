import 'package:flutter/material.dart';
import 'package:portal_berita/model/berita.dart';

class DetailBeritaPage extends StatelessWidget {
  final Berita? berita;

  DetailBeritaPage(this.berita);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NEO NEWS'),
          backgroundColor: Colors.greenAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Judul',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${berita!.judul}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pengarang',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${berita!.pengarang}'),
                  Text(
                    'Tanggal',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${berita!.tanggal}'),
                  Text(
                    'Isi',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text('${berita!.isi}'),
                ],
              ),
            )
          ]),
        ));
  }
}
