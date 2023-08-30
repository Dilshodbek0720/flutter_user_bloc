import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_bloc/blocs/users_bloc.dart';
import 'package:flutter_user_bloc/blocs/users_event.dart';
import 'package:flutter_user_bloc/blocs/users_state.dart';
import 'package:flutter_user_bloc/models/form_status.dart';
import 'package:flutter_user_bloc/models/user_model.dart';
import 'package:flutter_user_bloc/ui/users/widgets/global_button.dart';
import 'package:flutter_user_bloc/ui/users/widgets/global_text_fields.dart';
import 'package:flutter_user_bloc/utils/ui_utils/show_error_message.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  @override
  void initState() {
    firstNameController = TextEditingController(text: widget.userModel.firstName);
    lastNameController = TextEditingController(text: widget.userModel.lastName);
    ageController = TextEditingController(text: widget.userModel.age);
    genderController = TextEditingController(text: widget.userModel.gender);
    jobTitleController = TextEditingController(text: widget.userModel.jobTitle);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Add User"),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        builder: (context, state){
          return ListView(
            children: [
              const SizedBox(height: 30,),
              GlobalTextField(hintText: "FirstName", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: firstNameController),
              GlobalTextField(hintText: "LastName", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: lastNameController),
              GlobalTextField(hintText: "Age", keyboardType: TextInputType.number, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: ageController),
              GlobalTextField(hintText: "Gender", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: genderController),
              GlobalTextField(hintText: "Job Title", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: jobTitleController),
              const SizedBox(height: 30,),
              GlobalButton(title: "Update User", onTap: (){
                if(firstNameController.text.isNotEmpty&&lastNameController.text.isNotEmpty&&ageController.text.isNotEmpty&&genderController.text.isNotEmpty&&jobTitleController.text.isNotEmpty){
                  BlocProvider.of<UsersBloc>(context).add(UpdateUser(updatedUser: UserModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      age: ageController.text,
                      gender: genderController.text,
                      jobTitle: jobTitleController.text,
                      id: widget.userModel.id
                  )));
                }else{
                  showErrorMessage(message: "Malumotlar to'liq emas", context: context);
                }
              })
            ],
          );
        },
        listener: (context, state){
          if(state.status == FormStatus.success){
            BlocProvider.of<UsersBloc>(context).add(GetUsers());
            Navigator.pop(context);
          }
          if(state.status == FormStatus.error){
            showErrorMessage(message: state.statusText, context: context);
          }
        },
      ),
    );
  }
}
