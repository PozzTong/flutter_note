import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_vscode/global/data/colors.dart';
import 'package:flutter_app_vscode/global/style/style_widget.dart';
import 'package:flutter_app_vscode/model/category_model.dart';
import 'package:hexcolor/hexcolor.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int index = 0;
  String selectColor = '#0cd2ca';
  void setInsexColor(String colorCode) {
    setState(() {
      selectColor = colorCode;
    });
  }

  // List<CategoryModel> categorys = [];
  // getCategory()async{
  //   await
  // }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController selectColorController = TextEditingController();
  CategoryModel? categoryModel;
  // @override
  // void initState() {
  //   
  //   super.initState();
  //   getCategory();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 100,
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeS,
              ),
            ),
          ),
          title: const Text("Add Note"),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: fontSizeS),
                ))
          ],
        ),
        body: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        gapPadding: 4, borderRadius: BorderRadius.circular(20)),
                    hintText: "Title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                maxLines: 8,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        gapPadding: 4, borderRadius: BorderRadius.circular(20)),
                    hintText: "Write a note......"),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Card(
                // color: HexColor(selectColor),
                elevation: 0,
                child: Row(children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: fontSizeM,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.radio_button_checked_sharp,
                    size: 30,
                    color: HexColor(selectColor),
                  ),
                  Expanded(
                    flex: 6,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<CategoryModel>(
                        isExpanded: true,
                        dropdownSearchData: DropdownSearchData(
                          searchController: selectColorController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 60,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: selectColorController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'select',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value!.name
                                .toString()
                                .toLowerCase()
                                .contains(searchValue.toLowerCase()));
                          },
                        ),
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            selectColorController.clear();
                          }
                        },
                        hint: const Row(
                          children: [
                            Expanded(
                                child: Text(
                              'select Category',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                        items: categorys
                            .map(
                              (brand) => DropdownMenuItem<CategoryModel>(
                                value: brand,
                                child: Text(
                                  brand.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        value: categoryModel,
                        onChanged: (value) {
                          setState(() {
                            categoryModel = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 400,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          // ignore: deprecated_member_use
                          isFullScreen: true,
                          maxHeight: 250,
                          width: 270,
                          padding: null,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14)),
                          offset: const Offset(0, 0),
                          scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(10),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true)),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14)),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: colorsData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setInsexColor(colorsData[index]);
                      },
                      child: buildWidgetColors(colorCode: colorsData[index])),
                ),
              ),
            )
          ],
        ));
  }

  Widget buildWidgetColors({String? colorCode = '#0cd2ca'}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        maxRadius: 16,
        minRadius: 10,
        backgroundColor: HexColor(colorCode!),
        child: selectColor == colorCode
            ? const Center(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
