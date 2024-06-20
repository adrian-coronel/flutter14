import 'package:flutter/material.dart';
import 'package:flutter20062024/model/team.dart';
import 'package:flutter20062024/repository/impl/teamdbimpl.dart';
import 'package:flutter20062024/team_edit_form.dart';
import 'team_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Teams',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TeamListScreen(),
    );
  }
}

class TeamListScreen extends StatelessWidget {
  final TeamRepositoryImpl _teamRepository = TeamRepositoryImpl();

  Future<List<Team>> _loadTeams() {
    return _teamRepository.findAll();
  }

  Future<void> _addTeam(BuildContext context) async {
    final newTeam = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTeamScreen()),
    );
    if (newTeam != null) {
      await _teamRepository.create(newTeam);
      (context as Element).reassemble();
    }
  }

  Future<void> _editTeam(BuildContext context, Team team) async {
    final updatedTeam = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTeamScreen(team: team)),
    );
    if (updatedTeam != null) {
      await _teamRepository.update(updatedTeam);
      (context as Element).reassemble();
    }
  }

  Future<void> _deleteTeam(BuildContext context, int id) async {
    await _teamRepository.delete(id);
    (context as Element).reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Teams'),
      ),
      body: FutureBuilder<List<Team>>(
        future: _loadTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No teams found'));
          } else {
            final teams = snapshot.data!;
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(teams[index].name),
                  subtitle: Text('Founded: ${teams[index].foundingYear}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editTeam(context, teams[index]),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTeam(context, teams[index].id),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTeam(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
