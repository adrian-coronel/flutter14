

import 'package:flutter20062024/db/db.dart';
import 'package:flutter20062024/model/team.dart';
import 'package:flutter20062024/repository/interf/teamdb.dart';

class TeamRepositoryImpl implements ITeamRepository {

  Future<List<Team>> findAll() async {
    final db = await ConnDatabase.connections.database;
    final result = await db.query(Team.TableNameTeam);
    return result.map((map) => Team.fromMap(map)).toList();
  }

  Future<Team> findById(int id) async {
    final db = await ConnDatabase.connections.database;
    final result = await db.query(
      Team.TableNameTeam,
      columns: ['*'],
      where: '_id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty){
      throw Exception('Id $id not found');
    }
    return Team.fromMap(result.first);
  }

  Future<void> create(Team team) async {
    final db = await ConnDatabase.connections.database;
    final id = await db.insert(Team.TableNameTeam, team.toMap());

  }

  Future<int> update(Team team) async {
    final db = await ConnDatabase.connections.database;
    return db.update(Team.TableNameTeam,
    team.toMap(),
    where: '_id = ?',
    whereArgs: [team.id]
    );

  }

  Future<int> delete(int id) async {
    final db = await ConnDatabase.connections.database;
    return await db.delete(
      Team.TableNameTeam,
      where: '_id = ?',
      whereArgs: [id],
    );

  }

}