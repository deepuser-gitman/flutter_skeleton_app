import 'package:flutter/material.dart';

import '../../database/baby_database.dart';
import '../../models/baby.dart';

class AddBabyScreen extends StatefulWidget {
  final Function onBabyAdded;

  AddBabyScreen({required this.onBabyAdded});

  static const routeName = '/add_baby';

  @override
  _AddBabyScreenState createState() => _AddBabyScreenState();
}

class _AddBabyScreenState extends State<AddBabyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Baby'),
        ),
        // body: Padding(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _genderController,
                      decoration: InputDecoration(labelText: 'Gender'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a gender';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _birthdateController,
                      decoration: InputDecoration(labelText: 'Birthdate'),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a birthdate';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _fatherNameController,
                      decoration: InputDecoration(labelText: 'Father\'s Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter father\'s name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _motherNameController,
                      decoration: InputDecoration(labelText: 'Mother\'s Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter mother\'s name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(labelText: 'Weight'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter weight';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final baby = Baby(
                            name: _nameController.text,
                            gender: _genderController.text,
                            birthdate:
                                DateTime.parse(_birthdateController.text),
                            fatherName: _fatherNameController.text,
                            motherName: _motherNameController.text,
                            weight: double.parse(_weightController.text),
                          );
                          await addBaby(baby);
                          if (mounted && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Baby added successfully!')),
                            );
                            widget.onBabyAdded();
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text('Add Baby'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
