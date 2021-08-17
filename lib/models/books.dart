class Books {
  final int id;
  final String booksDesc;
  final String booksName;
  final String booksAuth;
  final String booksCate;
  final int pubyear;
  final String image;

  Books({ this.id, this.booksDesc, this.booksName, this.booksAuth,this.booksCate,this.pubyear,this.image });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': booksDesc,
      'name': booksName,
      'auth' : booksAuth,
      'cate' : booksCate,
      'pubyear' : pubyear,
      'image' : image,
    };
  }

  @override
  String toString() {
    return 'Books{id: $id, booksName: $booksName, pubyear:$pubyear}';
  }

}