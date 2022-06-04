import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/patient_layout/screens/profile/widgets/profile_Action_Widget.dart';
import 'package:medicine_tracker/patient_layout/screens/profile/widgets/user_widget.dart';
import 'package:medicine_tracker/relative_layout/screens/my_requests_screen/my_requests_screen.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class RelativeProfileScreen extends StatelessWidget {
  const RelativeProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: UserWidget(),
                ),
                ProfileActionWidget(
                    onTap: () {
                      navigateTo(context, MyRequestsScreen());
                    },
                    text: 'Requests'),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
