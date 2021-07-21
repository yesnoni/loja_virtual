
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier{

  ProductManager(){

    _loadAllProduct();

  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  List<Product> allProducts = [];

  Future<void> _loadAllProduct() async {

    //pega todos os documentos da coleção products e quarda no objeto snapProducts
    final QuerySnapshot snapProducts = await firestore.collection('products').get();

    //tranforma os documentos de snapProducts em uma lista de Produtos
    allProducts = snapProducts.docs.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();

  }

}

