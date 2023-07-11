import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_vscode/database/category_connection.dart';
import 'package:flutter_app_vscode/global/constant/data_fiels.dart';
import 'package:flutter_app_vscode/model/category_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController controller = TextEditingController();
  List<CategoryModel> categoryList = [];
  getCategory() async {
    await CategoryDB().getCategory().then((value) {
      setState(() {
        categoryList = value;
      });
    });
  }

  @override
  void initState() {
    // TO DO: implement initState
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        centerTitle: true,
      ),
      body: Column(children: [
        Flexible(
            child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Category Name"),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                elevation: 0,
                heroTag: 'save',
                backgroundColor: Colors.white,
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    await CategoryDB()
                        .insertCategory(CategoryModel(
                            id: DateTime.now().microsecondsSinceEpoch,
                            name: controller.text))
                        .whenComplete(() => getCategory());
                  }
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ))
          ],
        )),
        Expanded(
          child: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) => Card(
              elevation: 0,
              child: Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: null,
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await CategoryDB()
                            .deleteCategory(categoryList[index].id)
                            .whenComplete(() => getCategory());
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              buildDialog(categoryList[index]),
                        );
                      },
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit_note_rounded,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(categoryList[index].name),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget buildDialog(CategoryModel categoryModel) {
    var categoryController = TextEditingController();
    categoryController.text = categoryModel.name;

    return SizedBox(
      height: 350,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Update Category",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: categoryController,
              decoration:const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Category Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: const Text("save"),
                onPressed: () async {
                  await CategoryDB()
                      .updateCategory(CategoryModel(
                          id: categoryModel.id, name: categoryController.text))
                      .then((value) => Navigator.pop(context))
                      .then((value) => getCategory());
                }),
          )
        ],
      ),
    );
  }
}
