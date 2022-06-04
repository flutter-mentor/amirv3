import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../network/local/cash_helper.dart';
import '../componenets/componenets.dart';
import '../const/const.dart';
import '../global_widgets/adabtive_simple_dialogue.dart';
import '../global_widgets/adabtive_spinnerr.dart';
import '../global_widgets/custom_text_filled.dart';
import '../global_widgets/primary_button.dart';
import '../patient_layout/patient_layout.dart';
import 'auth_screen.dart';

class CreateAnAccontScreen extends StatelessWidget {
  const CreateAnAccontScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fromKey = GlobalKey<FormState>();
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Create an account',
          ),
        ),
        body: Form(
          key: fromKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFilled(
                        label: 'E-mail',
                        readOnly: false,
                        height: 55,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'E-mail address is required';
                          }
                        },
                        keyboard: TextInputType.emailAddress,
                        isPasword: false,
                        controller: MedCubit.get(context).emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFilled(
                        label: 'First name',
                        readOnly: false,
                        height: 55,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'First name is required';
                          }
                        },
                        isPasword: false,
                        controller: MedCubit.get(context).nameController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFilled(
                        label: 'Last name',
                        readOnly: false,
                        inputFormatters: [
                          // FilteringTextInputFormatter.deny(RegExp("[a-zA-Z]")),
                        ],
                        height: 55,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Last name is required';
                          }
                        },
                        isPasword: false,
                        controller: MedCubit.get(context).lNAmeController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFilled(
                        label: 'Mobile number',
                        readOnly: false,
                        height: 55,
                        keyboard: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (val.length < 11) {
                            return 'Incorrect phone number';
                          }
                        },
                        isPasword: false,
                        controller: MedCubit.get(context).phoneController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFilled(
                      label: 'Password',
                      readOnly: false,
                      height: 55,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Password  is required';
                        }
                      },
                      isPasword: MedCubit.get(context).isPassword,
                      controller: MedCubit.get(context).passwordController,
                      suffix: InkWell(
                        onTap: () {
                          MedCubit.get(context).changePAsswordBehavior();
                        },
                        child: Text(
                          MedCubit.get(context).obSecureText,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('You are '),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var patient = false;
                                MedCubit.get(context).notPatient(patient);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: MedCubit.get(context).patient ==
                                                false
                                            ? AppColors.primColor
                                            : Colors.grey)),
                                child: Text(
                                  'Relative',
                                  style: TextStyle(
                                      color:
                                          MedCubit.get(context).patient == false
                                              ? AppColors.primColor
                                              : Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                var patient = true;
                                MedCubit.get(context).notPatient(patient);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: MedCubit.get(context).patient ==
                                                true
                                            ? AppColors.primColor
                                            : Colors.grey)),
                                child: Text(
                                  'Patient',
                                  style: TextStyle(
                                      color:
                                          MedCubit.get(context).patient == true
                                              ? AppColors.primColor
                                              : Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is SignUpLoading)
                      CustomAdabtiveSpinner(isIos: Platform.isIOS),
                    if (state is! SignUpLoading)
                      PrimaryButton(
                          text: 'Create an acconunt',
                          color: AppColors.primColor,
                          width: double.infinity,
                          height: 50,
                          onPressed: () {
                            if (fromKey.currentState!.validate()) {
                              MedCubit.get(context).signUp(
                                  email: MedCubit.get(context)
                                      .emailController
                                      .text
                                      .trim(),
                                  password: MedCubit.get(context)
                                      .passwordController
                                      .text,
                                  name:
                                      MedCubit.get(context).nameController.text,
                                  phone: MedCubit.get(context)
                                      .phoneController
                                      .text,
                                  lName: MedCubit.get(context)
                                      .lNAmeController
                                      .text);
                            }
                          }),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              navigateAndFinish(context, AuthScreen());
                            },
                            child: Text(
                              'Already have an account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            )),
                      ],
                    ),
                    Container(
                      child: Text(
                        'Creating an account means you agree to our privacy policy\nGet well soon..',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SignUpError) {
        showDialog(
            context: context,
            builder: (context) => AdabtiveSimpleDialogue(
                title: Text(MedCubit.get(context).errorMessage)));
      }
      if (state is CreateUserDone) {
        CacheHelper.saveData(key: 'uid', value: state.uid);
        uId = CacheHelper.getData(key: 'uid');
        MedCubit.get(context).getUserData();
        navigateAndFinish(context, PatientLayout());
        MedCubit.get(context).getUserData();
      }
      if (state is SignupDoneState) {
        CacheHelper.saveData(key: 'uid', value: state.uId);
        uId = CacheHelper.getData(key: 'uid');
        MedCubit.get(context).getUserData();
        navigateAndFinish(context, PatientLayout());
        MedCubit.get(context).getUserData();
      }
    });
  }
}
