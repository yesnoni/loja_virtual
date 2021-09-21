import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/models/usuario.dart';
class CartManager{

  List<CartProduct> items = [];
  User user;
  Usuario usuario;
  //Usuario cartReference;


  void updateUser(UserManager userManager){
    user = userManager.user;
    usuario = userManager.user as Usuario;
    items.clear();

    if (user != null){
      _loadCartItems();
    }
  }
  //busca os documentos em cart no banco
  Future<void> _loadCartItems()async{

    final QuerySnapshot cartSnap = await usuario.cartReference.get();

    items = cartSnap.docs.map((d) => CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }

}