import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text("EchoShop"),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeManager>(
                  builder:(_, homeManager, __){

                    final List<Widget> children = homeManager.sections.map<Widget>(
                            (section){switch(section.type){
                              case 'List' : return SectionList(section);
                              case 'Staggered' : return Container();
                              default : return Container();
                            }}).toList();

                    return SliverList(
                      delegate: SliverChildListDelegate(children),
                    );
                  }
              ),
            ],
          ),
        ]
      ),
    );
  }
}
