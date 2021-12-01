import 'package:app/classes/dialog_box.dart';
import 'package:app/classes/form_fields/description_field.dart';
import 'package:app/classes/form_fields/form_field.dart';
import 'package:app/classes/form_fields/price_field.dart';
import 'package:app/classes/globals.dart';
import 'package:app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateListing extends StatefulWidget {
  const CreateListing({Key? key}) : super(key: key);

  @override
  _CreateListingState createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // space between fields
  final double spacer = 20.0;
  // the image the user chose
  File? image;
  // controllers for getting text from fields
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // stores the assigned tag
  String tag = 'Choose a tag';

  @override
  Widget build(BuildContext context) {
    // put the whole body in a listview so it can scroll
    return ListView(
      children: [
        // Code related to picking and displaying the image
        Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                image == null
                    ? GestureDetector(
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 40.0, horizontal: 0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 50.0,
                                  color: custom_colour,
                                ),
                                Text(
                                  "select a photo",
                                  style: TextStyle(
                                      fontSize: 20, color: custom_colour),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: custom_colour,
                                    width: 2.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(20.0))),
                        onTap: () async {
                          var result = await selectImage();
                          setState(() {
                            image = result;
                          });
                        },
                      )
                    : Column(
                        children: [
                          ConstrainedBox(
                            constraints: new BoxConstraints(
                              minWidth: double.infinity,
                              maxHeight: 200.0,
                              maxWidth: double.infinity,
                            ),
                            child: Image.file(
                              image!,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          ElevatedButton.icon(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                              onPressed: () async {
                                var result = await selectImage();
                                setState(() {
                                  image = result;
                                });
                              },
                              icon: Icon(Icons.add_a_photo),
                              label: Text("Pick a new image"))
                        ],
                      ),
              ],
            )),
        // code related to the form fields the user must fill in
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
            child: Column(children: [
              FormWidget(
                  controller: titleController,
                  obscure: false,
                  text: "Title",
                  prefix: const Icon(Icons.title)),
              SizedBox(height: spacer),
              PriceWidget(
                controller: priceController,
              ),
              SizedBox(height: spacer),
              DescriptionWidget(
                controller: descriptionController,
              ),
              SizedBox(
                width: spacer,
              ),
              DropdownButton<String>(
                value: tag,
                icon: Row(children: [
                  SizedBox(
                    height: 10,
                    width: 100,
                  ),
                  Icon(Icons.arrow_drop_down)
                ]),
                iconSize: 24,
                underline: Container(
                  height: 2,
                  color: custom_colour,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    tag = newValue!;
                  });
                },
                items: <String>[
                  'Choose a tag',
                  'Apparel',
                  'Accessories',
                  'Auto',
                  'Bikes',
                  'Books',
                  'Collectibles',
                  'Furniture',
                  'gaming',
                  'Laptops',
                  'Phones',
                  'Tech',
                  'Watches'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
          ),
        ),
        // the upload button
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 30.0),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // user did not choose a tag, don't go any further
                  if (tag == 'Choose a tag') {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Select a tag")));
                    // user did not choose an image, don't go any further
                  } else if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Select an image")));
                    // put the listing in firebase
                  } else {
                    var title = titleController.text.toString();
                    var description = descriptionController.text.toString();
                    var price = double.parse(priceController.text.toString());
                    var result = await DatabaseService()
                        .createListing(title, description, tag, price, image!);
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to upload listing")));
                    } else {
                      showAlertDialog(
                          context, "Success, listing has been posted");
                      setState(() {
                        image = null;
                        titleController.clear();
                        priceController.clear();
                        descriptionController.clear();
                        tag = 'Choose a tag';
                      });
                    }
                  }
                }
              },
              icon: const Icon(Icons.upload),
              label: const Text(
                "Create Listing",
                style: TextStyle(fontSize: 20.0),
              )),
        )
      ],
    );
  }

  selectImage() async {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result == null) {
      return null;
    }
    return File(result.path);
  }
}
