// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:brasileirao/models/time.dart';
import 'package:brasileirao/pages/time_page.dart';
import 'package:flutter/material.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brasileirão'),
      ),
      body: ListView.separated(
        itemCount: controller.tabela.length,
        itemBuilder: (context, index) {
          final List<Time> tabela = controller.tabela;
          return ListTile(
            leading: Image.network(tabela[index].brasao),
            title: Text(tabela[index].nome),
            trailing: Text(tabela[index].pontos.toString()),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TimePage(
                            key: Key(tabela[index].nome),
                            time: tabela[index],
                          )));
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
