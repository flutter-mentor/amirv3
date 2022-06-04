import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import 'package:medicine_tracker/relative_layout/my_patient_reminder_card.dart';
import '../../../componenets/componenets.dart';
import '../../widgets/my_patient_details_card.dart';
import '../patient_reminder_activity/patient_reminder_activity_screen.dart';

class MyPatientActivityScreen extends StatelessWidget {
  String patientID;
  MyPatientActivityScreen({
    Key? key,
    required this.patientID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      RelCubit.get(context).getPatientActivity(patientID);

      return BlocConsumer<RelCubit, RelativeStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Column(
                  children: [
                    RelCubit.get(context).patientModel != null
                        ? Text(
                            '${RelCubit.get(context).patientModel!.name} ${RelCubit.get(context).patientModel!.lastname}')
                        : SizedBox(),
                    Text(
                      'Today\'s activity',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    RelCubit.get(context).patientModel != null
                        ? MyPatientDetailsWidget()
                        : SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemBuilder: (context, index) {
                          var reminder =
                              RelCubit.get(context).myPatintsReminder[index];
                          return MyPatientReminderCard(reminderModel: reminder);
                        },
                        itemCount:
                            RelCubit.get(context).myPatintsReminder.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {});
    });
  }
}
