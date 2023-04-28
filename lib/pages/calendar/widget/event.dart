import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/metas/metas_cubit.dart';
import '../../pomodoro/pomodoro.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.index, required this.meta});
  final int index;
  final Map<String, dynamic> meta;

  @override
  Widget build(BuildContext context) {
    final MetasCubit cubit = context.read<MetasCubit>();
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => BlocProvider.value(
          value: cubit,
          child: PomodoroPage( nameSubject: '',),
        ),),);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0.03, 0.03], colors: [Colors.indigo, Colors.black12]),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Text(
                      meta['disciplina'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children:[
                          
                          Text('programado para: ${meta['horario_meta']}'),
                          const SizedBox(width: 6),
                                      
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.notifications),
              )
            ],
          ),
        ),
      ),
    );
  }
}
