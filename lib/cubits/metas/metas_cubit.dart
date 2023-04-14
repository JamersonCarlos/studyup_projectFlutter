import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/firebse_service.dart';
import 'package:meta/meta.dart';

part 'metas_state.dart';

class MetasCubit extends Cubit<MetasState> {
  final FirebaseService service = FirebaseService();
  late List<dynamic> metasByUser = [];
  MetasCubit() : super(MetasInitial());

  Future<void> getMetasByUidUser(String uid) async {
    try {
      emit(MetasLoading());
      if (metasByUser.isNotEmpty) {
        emit(MetasLoaded(metas: metasByUser));
      } else {
        emit(MetasLoading());
        metasByUser = await service.getMetasByUidUser(uid);
        emit(MetasLoaded(metas: metasByUser));
      }
    } catch (e) {
      emit(MetasError());
    }
  }

  Future<void> FilterMetasByDay(DateTime day) async {
    List listForFilter = [];
    emit(MetasLoading());
    for (int i = 0; i < metasByUser.length; i++) {
      if (day.day ==
          transformData(metasByUser[i] as Map<String, dynamic>).day) {
        listForFilter.add(metasByUser[i]);
      }
    }
    emit(MetasLoaded(metas: listForFilter));
  }

  void updateEnvarimentIa(String uid) async {
    await service.updateEnvarimentIa(uid);
  }

  DateTime transformData(Map<String, dynamic> meta) {
    
    String dateString = "${meta['dataMeta']+"T"+meta['horario_meta']}0:00.000Z";
    print(dateString);
    try{
      DateTime date = DateTime.parse(dateString);
      return date;
    }catch(e){
      return DateTime.now();
    }
    
  }
}
