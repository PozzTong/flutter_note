import 'package:flutter/material.dart';
import 'package:flutter_app_vscode/screen/category/add_category_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        buildCardWidget(context),
        const Divider(
          color: Colors.black,
          endIndent: 10,
          indent: 10,
        ),
        buildCardWidget(context),
        const Divider(
          color: Colors.black,
          endIndent: 10,
          indent: 10,
        ),
        buildCardWidget(context),
      ],
    ));
  }

  Widget buildCardWidget(BuildContext context) {
    return Card(
      elevation: 0,
      child: Wrap(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCategory(),
                  ));
            },
            leading: const CircleAvatar(
              maxRadius: 20,
              child: Center(
                child: Icon(
                  Icons.category,
                  size: 30,
                ),
              ),
            ),
            title: const Text("Add Category"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
