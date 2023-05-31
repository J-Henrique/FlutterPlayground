import 'package:brasileirao/models/titulo.dart';
import 'package:brasileirao/repository/times_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditTituloPage extends StatefulWidget {
  final Titulo titulo;

  const EditTituloPage({Key? key, required this.titulo}) : super(key: key);

  @override
  State<EditTituloPage> createState() => _EditTituloPageState();
}

class _EditTituloPageState extends State<EditTituloPage> {
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ano.text = widget.titulo.ano;
    _campeonato.text = widget.titulo.campeonato;
  }

  editar() {
    Provider.of<TimesRepository>(context, listen: false).editTitulo(
      titulo: widget.titulo,
      ano: _ano.text,
      campeonato: _campeonato.text,
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar titulo'),
        backgroundColor: Colors.grey[800],
        actions: [IconButton(onPressed: editar, icon: const Icon(Icons.check))],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                controller: _ano,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty != null) {
                    return 'Informe o ano do titulo';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: TextFormField(
                controller: _campeonato,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Campeonato'),
                validator: (value) {
                  if (value?.isEmpty != null) {
                    return 'Informe qual é o campeonato';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() != null) {
                      editar();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Salvar',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
