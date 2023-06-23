import 'package:brasileirao/models/titulo.dart';
import 'package:flutter/material.dart';

class Time {
  int? id;
  String nome;
  String brasao;
  int pontos;
  Color? cor;
  // int idAPI;
  List<Titulo> titulos;

  Time({
    this.id,
    required this.brasao,
    required this.nome,
    required this.pontos,
    this.cor,
    this.titulos = const [],
    // required this.idAPI,
  });
}
