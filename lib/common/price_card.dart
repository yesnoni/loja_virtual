import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {

   const PriceCard({this.buttonText, this.onPressed});

  final  String buttonText;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            const Text(
              "Resumo do Pedido",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal"),
                Text("R\$ ${productsPrice.toStringAsFixed(2)}")
              ],
            ),
            const Divider(),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text("R\$ ${productsPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8,),
             RaisedButton(
              color: Colors.green,
              disabledColor: Colors.green.withAlpha(100),
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}
