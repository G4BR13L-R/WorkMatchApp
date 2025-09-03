import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:work_match_app/data/models/cidade_model.dart';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/ui/screens/widgets/custom_text_field.dart';

class CidadeAutoComplete extends StatefulWidget {
  final CidadeModel? initialValue;
  final Function(CidadeModel)? onSelected;

  const CidadeAutoComplete({super.key, this.initialValue, this.onSelected});

  @override
  State<CidadeAutoComplete> createState() => _CidadeAutoCompleteState();
}

class _CidadeAutoCompleteState extends State<CidadeAutoComplete> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    String valueInitial = '';
    if (widget.initialValue != null) {
      valueInitial = "${widget.initialValue!.descricao} - ${widget.initialValue!.estado?.sigla ?? ''}";
    }

    _controller = TextEditingController(text: valueInitial);
  }

  Future<List<CidadeModel>> _buscarCidades(String query) async {
    if (query.isEmpty) return [];

    final response = await ApiClient.get("/cidades/search/$query");

    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body) as List;
    return data.map((e) => CidadeModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<CidadeModel>(
      suggestionsCallback: (pattern) => _buscarCidades(pattern),
      controller: _controller,
      builder: (context, controller, focusNode) {
        return CustomTextField(
          controller: controller,
          hintText: "Cidade",
          icon: Icons.location_city,
          focusNode: focusNode,
        );
      },
      itemBuilder: (context, cidade) {
        return ListTile(title: Text("${cidade.descricao} - ${cidade.estado?.sigla ?? ''}"));
      },
      emptyBuilder: (context) {
        return const ListTile(title: Text("Nenhuma cidade encontrada"));
      },
      onSelected: (CidadeModel value) {
        setState(() {
          _controller.text = "${value.descricao} - ${value.estado?.sigla ?? ''}";
        });

        if (widget.onSelected != null) {
          widget.onSelected!(value);
        }
      },
    );
  }
}
