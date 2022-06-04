import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var days =
        DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;

    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Progress'
                  //  DateFormat('EEEE').format(DateTime.now()),
                  ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(days[index]),
                          );
                        },
                        itemCount: days.length,
                      ))
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
