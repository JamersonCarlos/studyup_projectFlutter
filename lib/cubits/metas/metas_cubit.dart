import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/firebse_service.dart';
import 'package:meta/meta.dart';

part 'metas_state.dart';

class MetasCubit extends Cubit<MetasState> {
  final FirebaseService service = FirebaseService();
  late List<dynamic> metasByUser = [];
  late DateTime focusedDay = DateTime.now();
  MetasCubit() : super(MetasInitial());

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

  Future<void> filterMetasByDay(DateTime day) async {
    emit(MetasLoading());
    filterMetasForDate(day);
    emit(MetasLoaded(metas: filterMetasForDate(day)));
  }

  filterMetasForDate(DateTime day) {
    focusedDay = day;
    List listForFilter = [];
    for (int i = 0; i < metasByUser.length; i++) {
      var textodata = _transformData(metasByUser[i] as Map<String, dynamic>);

      if (day.day == textodata.day &&
          day.month == textodata.month &&
          day.year == textodata.year) {

        listForFilter.add(metasByUser[i]);
        
      }
    }
    listForFilter.sort((a, b) {
          var dateA =_transformData(a as Map<String, dynamic>);
          var dateB =_transformData(b as Map<String, dynamic>);
          return dateA.compareTo(dateB);
        });
    return listForFilter;
  }


  void updateEnvarimentIa(String uid, double reforco) async {
    await service.updateEnvarimentIa(uid, reforco);
  }

  DateTime _transformData(Map<String, dynamic> meta) {
    String dateString =
        "${meta['dataMeta'] + "T" + meta['horario_meta']}0:00.000Z";
    try {
      DateTime date = DateTime.parse(dateString);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }
}
