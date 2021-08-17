import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/product/components/size_widget.dart';
import 'package:provider/provider.dart';



class ProductScreen extends StatelessWidget {

  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: product,
        child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.name,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url){
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "A partir de: ",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      )
                    ),
                  ),
                  const Text(
                    "R\$19,99",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                        "Descrição",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )
                    ),
                  ),
                  Text(
                    product.description,
                    style:const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                        "Tamanhos",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                      product.sizes.map((s){
                        return SizeWidget(size:s);
                      }).toList(),
                  ),
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __){
                        return SizedBox(
                          height: 44,
                        child: RaisedButton(
                          onPressed: product.selectedSize != null ?(){
                            if (userManager.isLoggedIn){
                              //TODO: ADICIONAR AO CARRINHO
                            }else{
                              Navigator.of(context).pushNamed('/login');
                            }
                          } : null ,
                          textColor: Colors.white,
                          color: Colors.green,
                          child: Text(
                            userManager.isLoggedIn ? 'Adicionar ao carrinho' : 'Entre para Comprar',
                            style: const TextStyle(fontSize: 18),
                          ),

                        ),
                        );
                      },
                    )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
