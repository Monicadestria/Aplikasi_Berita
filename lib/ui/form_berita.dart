import 'package:flutter/material.dart';
import 'package:portal_berita/db/db_helper.dart';
import 'package:portal_berita/model/berita.dart';

class FormBerita extends StatefulWidget {
  final Berita? berita;

  FormBerita({this.berita});

  @override
  _FormBeritaState createState() => _FormBeritaState();
}

class _FormBeritaState extends State<FormBerita> {
  DBHelper db = DBHelper();

  TextEditingController? judul;
  TextEditingController? pengarang;
  TextEditingController? tanggal;
  TextEditingController? isi;

  @override
  void initState() {
    judul = TextEditingController(
        text: widget.berita == null ? '' : widget.berita!.judul);
    pengarang = TextEditingController(
        text: widget.berita == null ? '' : widget.berita!.pengarang);
    tanggal = TextEditingController(
        text: widget.berita == null ? '' : widget.berita!.tanggal);
    isi = TextEditingController(
        text: widget.berita == null ? '' : widget.berita!.isi);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEO NEWS'),
        actions: [
          IconButton(
            onPressed: () {
              upsertBerita();
            },
            icon: Icon(Icons.save),
          ),
        ],
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                child: Column(children: [
                  TextFormField(
                    controller: judul,
                    decoration: InputDecoration(hintText: 'Judul'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: pengarang,
                    decoration: InputDecoration(hintText: 'Pengarang'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: tanggal,
                    decoration: InputDecoration(hintText: 'Tanggal'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: isi,
                    decoration: InputDecoration(hintText: 'Isi'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ],
          )),
    );
  }

  //update insert notes
  Future<void> upsertBerita() async {
    if (widget.berita != null) {
      //insert
      await db.updateBerita(Berita.fromMap({
        'id': widget.berita!.id,
        'judul': judul!.text,
        'pengarang': pengarang!.text,
        'tanggal': tanggal!.text,
        'isi': isi!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //update
      await db.saveBerita(Berita(
        judul: judul!.text,
        pengarang: pengarang!.text,
        tanggal: tanggal!.text,
        isi: isi!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
