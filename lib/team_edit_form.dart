import 'package:flutter/material.dart';
import 'package:flutter20062024/model/team.dart';

class EditTeamScreen extends StatelessWidget {
  final Team team;
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _dateChampController = TextEditingController();

  EditTeamScreen({required this.team}) {
    _nameController.text = team.name;
    _yearController.text = team.foundingYear.toString();
    _dateChampController.text = team.dateChamp.toIso8601String();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Team'),
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
                final updatedTeam = Team(
                  id: team.id,
                  name: _nameController.text,
                  foundingYear: int.parse(_yearController.text),
                  dateChamp: DateTime.parse(_dateChampController.text),
                );

                Navigator.pop(context, updatedTeam); // Devolver el equipo actualizado a la pantalla anterior
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
