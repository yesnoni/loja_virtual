import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/section_item.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document){
    name = document['name'] as String;
    type = document['type'] as String;
    items = (document['items'] as List).map((i) => SectionItem.fromMap(i as Map<String, dynamic>)).toList();
  }

  String name;
  String type;

  List<SectionItem> items;

}
