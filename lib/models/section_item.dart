class SectionItem{

  SectionItem.fromMap(Map<String, dynamic> map){
    image = map['image'] as String;
  }

  String image;

}