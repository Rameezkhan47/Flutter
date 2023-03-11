import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, Function tapHandler) { 
      return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        onTap: () {
          tapHandler();
        },
      );
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            child: Text("Welcome",
                style: Theme.of(context).textTheme.displayLarge),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () => Navigator.of(context).pushReplacementNamed('/'), //to clear out the pages stack so it doesnt back to drawer screen
          ),
          const Divider(),
          buildListTile(
            'Filters',
            Icons.filter,
            () => Navigator.of(context).pushReplacementNamed(FilterScreen.routeName),
          ),
        ],
      ),
    );
  }
}
