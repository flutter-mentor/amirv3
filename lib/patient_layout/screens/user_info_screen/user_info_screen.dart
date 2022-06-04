import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/const/const.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/adabtive_simple_dialogue.dart';
import '../../../global_widgets/custom_text_filled.dart';
import '../../../global_widgets/primary_button.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =
        TextEditingController(text: MedCubit.get(context).userModel!.eMail);
    var firstNameController =
        TextEditingController(text: MedCubit.get(context).userModel!.name);
    var lastNameController =
        TextEditingController(text: MedCubit.get(context).userModel!.lastname);
    var phoneNoController =
        TextEditingController(text: MedCubit.get(context).userModel!.phone);
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('User info'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFilled(
                  label: '',
                  readOnly: true,
                  isPasword: false,
                  height: 40,
                  controller: emailController,
                  validator: (val) {}),
              const SizedBox(
                height: 16,
              ),
              CustomTextFilled(
                  label: '',
                  readOnly: false,
                  isPasword: false,
                  height: 40,
                  controller: firstNameController,
                  validator: (val) {}),
              const SizedBox(
                height: 16,
              ),
              CustomTextFilled(
                  label: '',
                  readOnly: false,
                  isPasword: false,
                  height: 40,
                  controller: lastNameController,
                  validator: (val) {}),
              const SizedBox(
                height: 16,
              ),
              CustomTextFilled(
                  label: '',
                  readOnly: false,
                  isPasword: false,
                  height: 40,
                  controller: phoneNoController,
                  validator: (val) {}),
              const SizedBox(
                height: 16,
              ),
              if (state is UpdateUserLoading)
                LottieBuilder.asset(
                  'assets/loading.json',
                  width: 50,
                ),
              if (state is! UpdateUserLoading)
                PrimaryButton(
                    text: 'Update info',
                    width: double.infinity,
                    color: AppColors.primColor,
                    height: 50,
                    onPressed: () {
                      Map<String, dynamic> userData = {
                        'eMail': emailController.text,
                        'name': firstNameController.text,
                        'lastname': lastNameController.text,
                        'phone': phoneNoController.text
                      };

                      MedCubit.get(context).updateUserData(userMap: userData);
                    }),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is UpdateUserDataDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(title: Text('Data updated'));
            });
      }
    });
  }
}
