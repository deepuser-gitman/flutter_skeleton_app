import 'package:flutter/material.dart';

import '../../src/settings/settings_view.dart';
import '../../database/baby_database.dart';
import '../../models/baby.dart';
import 'add_baby_screen.dart';
import 'edit_baby_screen.dart';

class BabyListScreen extends StatefulWidget {
  const BabyListScreen({super.key});

  static const routeName = '/baby_list';

  @override
  _BabyListScreenState createState() => _BabyListScreenState();
}

class _BabyListScreenState extends State<BabyListScreen> {
  List<Baby> _babies = [];

  @override
  void initState() {
    super.initState();
    _fetchBabies();
  }

  Future<void> _fetchBabies() async {
    final babies = await getAllBabies();
    setState(() {
      _babies = babies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'babyListView',
        itemCount: _babies.length,
        itemBuilder: (context, index) {
          final baby = _babies[index];
          return ListTile(
            title: Text(baby.name),
            leading: const CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            subtitle: Text(baby.birthdate.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBabyScreen(
                    baby: baby,
                    onBabyEdited:
                        _fetchBabies, // Pass the _fetchBabies function as a callback
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBabyScreen(
                onBabyAdded:
                    _fetchBabies, // Pass the _fetchBabies function as a callback),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
