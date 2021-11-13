import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/models/usuario.dart';
class CartManager extends ChangeNotifier{

  List<CartProduct> items = [];
  User user;
  Usuario usuario;
  //Usuario cartReference;

  num productsPrice = 0.0;


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

    items = cartSnap.docs.map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)).toList();
  }

  void addToCart(Product product){

    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    }catch(e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      usuario.cartReference.add(cartProduct.toCartItemMap()).then((doc) => cartProduct.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct){
    items.removeWhere((p) => p.id == cartProduct.id);
    usuario.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated(){
    productsPrice = 0.0;

    for(int i = 0; i<items.length; i++){
      final cartProduct = items[i];

      if(cartProduct.quantity == 0){
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }

    notifyListeners();

  }

  void _updateCartProduct(CartProduct cartProduct){
    if(cartProduct.id != null) {
      usuario.cartReference.doc(cartProduct.id).update(cartProduct.toCartItemMap());
    }
  }

  bool get isCartValid {
    for(final cartProduct in items){
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }

}