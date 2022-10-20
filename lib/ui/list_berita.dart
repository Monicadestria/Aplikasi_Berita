import 'package:flutter/material.dart';
import 'package:portal_berita/db/db_helper.dart';
import 'package:portal_berita/model/berita.dart';
import 'package:portal_berita/ui/detail_berita.dart';
import 'package:portal_berita/ui/form_berita.dart';

class ListBeritaPage extends StatefulWidget {
  const ListBeritaPage({Key? key}) : super(key: key);

  @override
  _ListBeritaPageState createState() => _ListBeritaPageState();
}

class _ListBeritaPageState extends State<ListBeritaPage> {
  List<Berita> listBerita = [];
  DBHelper db = DBHelper();

  @override
  void initState() {
    _getAllBerita();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ui tampilan awal
    return Scaffold(
      appBar: AppBar(
        title: Text('NEO NEWS'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        itemCount: listBerita.length,
        itemBuilder: (context, index) {
          Berita berita = listBerita[index];
          return Container(
              child: Column(children: [
            ListTile(
              onTap: () {
                //edit
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBeritaPage(berita),
                    ));
              },
              contentPadding: EdgeInsets.all(16),
              title: Text(
                "${berita.judul}",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              //overflow: TextOverflow.ellipsis(pada text…)
              subtitle: Text(
                '${berita.tanggal}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  _deleteBerita(berita, index);
                },
                icon: Icon(Icons.delete),
              ),
              leading: IconButton(
                onPressed: () {
                  _openFormEdit(berita);
                },
                icon: Icon(Icons.edit),
              ),
            )
          ]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          //add
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllBerita() async {
    var list = await db.getAllBerita();
    setState(() {
      listBerita.clear();
      list!.forEach((berita) {
        listBerita.add(Berita.fromMap(berita));
      });
    });
  }

  //form create
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormBerita()));
    if (result == 'save') {
      await _getAllBerita();
    }
  }

  Future<void> _deleteBerita(Berita berita, int position) async {
    await db.deleteBerita(berita.id!);

    setState(() {
      listBerita.removeAt(position);
    });
  }

  //form edit
  Future<void> _openFormEdit(Berita berita) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormBerita(berita: berita)));

    if (result == 'update') {
      await _getAllBerita();
    }
  }
}
