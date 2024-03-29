import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/firebse_service.dart';
import 'package:meta/meta.dart';

part 'metas_state.dart';

class MetasCubit extends Cubit<MetasState> {
  final FirebaseService service = FirebaseService.instance;
  late List<dynamic> metasByUser = [];
  late String uid;
  late DateTime focusedDay = DateTime.now();
  MetasCubit() : super(MetasInitial()) {
    uid = service.uid;
  }

  Future<void> getMetasByUidUser(String uid) async {
    try {
      emit(MetasLoading());
      if (metasByUser.isNotEmpty) {
        emit(MetasLoaded(metas: filterMetasForDate(DateTime.now())));
      } else {
        emit(MetasLoading());
        metasByUser = await service.getMetasByUidUser(uid);
        emit(MetasLoaded(metas: filterMetasForDate(DateTime.now())));
      }
    } catch (e) {
      emit(MetasError());
    }
  }

  Future<void> getMetasByUidUserForPormodoroPage() async {
    emit(MetasLoading());
    var metas = await service.getAllSubjects();
    emit(MetasLoadedPomodoro(metas: metas));
  }

  Future<void> filterMetasByDay(DateTime day) async {
    emit(MetasLoading());
    filterMetasForDate(day);
    emit(MetasLoaded(metas: filterMetasForDate(day)));
  }

  filterMetasForDate(DateTime day) {
    focusedDay = day;
    List listForFilter = [];
    for (int i = 0; i < metasByUser.length; i++) {
      DateTime transformData =
          _transformData(metasByUser[i] as Map<String, dynamic>);
      if (day.day == transformData.day &&
          day.month == transformData.month &&
          day.year == transformData.year) {
        listForFilter.add(metasByUser[i]);
        
      }
    }
    listForFilter.sort((a, b) {
      DateTime aDate = _transformData(a as Map<String, dynamic>);
      DateTime bDate = _transformData(b as Map<String, dynamic>);
      return aDate.compareTo(bDate);
    });

    return listForFilter;
  }

  void updateEnvarimentIa(String disciplina, String uid, double reforco,
      int minutos, String horaDeIncio) async {
    await service.updateEnvarimentIa(
        disciplina, uid, reforco, minutos, horaDeIncio);
  }

  DateTime _transformData(Map<String, dynamic> meta) {
    String dateString =
        "${meta['dataMeta'] + "T" + meta['horario_meta']}:00.000Z";
    try {
      DateTime date = DateTime.parse(dateString);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }
}
