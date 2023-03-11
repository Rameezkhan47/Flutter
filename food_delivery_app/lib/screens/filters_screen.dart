import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  static final routeName = '/filters';
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters'),),
    );
  }
}