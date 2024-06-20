import 'package:flutter20062024/model/team.dart';

abstract class ITeamRepository {
  Future<List<Team>> findAll();

  Future<Team> findById(int id);

  Future<void> create(Team team);

  Future<int> update(Team team);

  Future<int> delete(int id);
}