import 'package:flutter/material.dart';
import 'package:flutter20062024/model/team.dart';

class AddTeamScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _dateChampController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Team'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Team Name'),
            ),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Founding Year'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dateChampController,
              decoration: InputDecoration(labelText: 'Date of Championship (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final id = DateTime.now().millisecondsSinceEpoch;
                final name = _nameController.text;
                final foundingYear = int.parse(_yearController.text);
                final dateChamp = DateTime.parse(_dateChampController.text);

                final newTeam = Team(
                  id: id,
                  name: name,
                  foundingYear: foundingYear,
                  dateChamp: dateChamp,
                );

                Navigator.pop(context, newTeam); // Devolver el nuevo equipo a la pantalla anterior
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
