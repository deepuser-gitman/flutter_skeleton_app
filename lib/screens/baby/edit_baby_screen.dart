import 'package:flutter/material.dart';

import '../../database/baby_database.dart';
import '../../models/baby.dart';

class EditBabyScreen extends StatefulWidget {
  final Baby baby;
  final Function onBabyEdited;

  EditBabyScreen({required this.baby, required this.onBabyEdited});

  static const routeName = '/edit_baby';

  @override
  _EditBabyScreenState createState() => _EditBabyScreenState();
}

class _EditBabyScreenState extends State<EditBabyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.baby.name;
    _genderController.text = widget.baby.gender;
    _birthdateController.text = widget.baby.birthdate.toString();
    _fatherNameController.text = widget.baby.fatherName;
    _motherNameController.text = widget.baby.motherName;
    _weightController.text = widget.baby.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Baby'),
      ),
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
                  // ... other TextFormField fields for gender, birthdate, etc.
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final updatedBaby = Baby(
                          id: widget.baby.id,
                          name: _nameController.text,
                          gender: _genderController.text,
                          birthdate: DateTime.parse(_birthdateController.text),
                          fatherName: _fatherNameController.text,
                          motherName: _motherNameController.text,
                          weight: double.parse(_weightController.text),
                          // ... other fields
                        );
                        await updateBaby(widget.baby.id, updatedBaby);
                        if (mounted && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Baby updated successfully!')),
                          );
                          widget.onBabyEdited(); // Call the callback function
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text('Update Baby'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
