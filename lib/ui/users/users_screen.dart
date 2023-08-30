import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_bloc/blocs/users_event.dart';
import 'package:flutter_user_bloc/blocs/users_state.dart';
import 'package:flutter_user_bloc/models/user_model.dart';
import 'package:flutter_user_bloc/ui/users/sub_screens/add_user_screen.dart';
import 'package:flutter_user_bloc/ui/users/sub_screens/update_user_screen.dart';

import '../../blocs/users_bloc.dart';
import '../../models/form_status.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Screen"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const AddUserScreen();
            }));
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<UsersBloc, UsersState>(
              builder: (context, state){
                return state.users.isNotEmpty ? ListView(
                  children: [
                    ...List.generate(state.users.length, (index) {
                      UserModel userModel = state.users[index];
                      return ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return UpdateUserScreen(userModel: userModel);
                          }));
                        },
                        title: Text(userModel.firstName),
                        subtitle: Text(userModel.lastName),
                        trailing: IconButton(
                          onPressed: (){
                            BlocProvider.of<UsersBloc>(context).add(DeleteUser(id: userModel.id!));
                            BlocProvider.of<UsersBloc>(context).add(GetUsers());
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    })
                  ],
                ) : const Center(child: Text("Empty"),);
              },
              listener: (context, state){

              }
          ),
          Visibility(
            visible:
            context.watch<UsersBloc>().state.status == FormStatus.loading,
            child: const Align(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
