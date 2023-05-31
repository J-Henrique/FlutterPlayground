// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:brasileirao/models/time.dart';
import 'package:brasileirao/pages/time_page.dart';
import 'package:brasileirao/repository/times_repository.dart';
import 'package:brasileirao/widgets/brasao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<TimesRepository>(builder: (context, repository, child) {
        return ListView.separated(
          itemCount: repository.times.length,
          itemBuilder: (context, index) {
            final List<Time> tabela = repository.times;
            return ListTile(
              leading: Brasao(
                image: tabela[index].brasao,
                width: 40,
              ),
              subtitle: Text('Títulos: ${tabela[index].titulos.length}'),
              title: Text(tabela[index].nome),
              trailing: Text(tabela[index].pontos.toString()),
              onTap: () {
                Get.to(() => TimePage(
                      key: Key(tabela[index].nome),
                      time: tabela[index],
                    ));
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
          padding: EdgeInsets.all(16),
        );
      }),
    );
  }
}
