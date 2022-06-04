import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/secondary_button.dart';
import 'package:medicine_tracker/models/relatives_model.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../componenets/componenets.dart';
import '../../global_widgets/circular_button.dart';
import '../../global_widgets/primary_button.dart';
import '../screens/activity_screen/activity_screen.dart';

class MyPatientCard extends StatelessWidget {
  RequestModel requestModel;
  MyPatientCard({
    Key? key,
    required this.requestModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit, RelativeStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          '${requestModel.name.characters.first.toUpperCase()}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        backgroundColor: AppColors.primColor.withOpacity(0.3),
                        foregroundColor: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${requestModel.name} ${requestModel.lastname}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                            text: 'activity',
                            width: double.infinity,
                            height: 45,
                            color: AppColors.primColor,
                            onPressed: () {
                              navigateTo(
                                  context,
                                  MyPatientActivityScreen(
                                      patientID: requestModel.uid));
                              RelCubit.get(context)
                                  .getPatientData(patientId: requestModel.uid);
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SecondaryButton(
                        onTap: () {
                          RelCubit.get(context)
                              .getPatientLocation(patientId: requestModel.uid);
                        },
                        icon: Icons.pin_drop_outlined,
                        color: AppColors.primColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SecondaryButton(
                        onTap: () {
                          RelCubit.get(context).callPatient(requestModel.phone);
                        },
                        icon: Icons.call,
                        color: AppColors.primColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SecondaryButton(
                        onTap: () {
                          RelCubit.get(context).waPatient(
                              wa: requestModel.phone,
                              quickMessage:
                                  'Hello ${requestModel.name} how are you today...?',
                              context: context);
                        },
                        icon: FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
