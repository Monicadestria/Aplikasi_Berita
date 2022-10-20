class Berita {
  int? id;
  String? judul;
  String? pengarang;
  String? tanggal;
  String? isi;

  Berita({this.id, this.judul, this.pengarang, this.tanggal, this.isi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['judul'] = judul;
    map['pengarang'] = pengarang;
    map['tanggal'] = tanggal;
    map['isi'] = isi;
    return map;
  }

  Berita.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.judul = map['judul'];
    this.pengarang = map['pengarang'];
    this.tanggal = map['tanggal'];
    this.isi = map['isi'];
  }
}
