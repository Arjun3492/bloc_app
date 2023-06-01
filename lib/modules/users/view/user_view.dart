import 'package:bloc_app/modules/users/controller/events/user_events.dart';
import 'package:bloc_app/modules/users/controller/states/user_states.dart';
import 'package:bloc_app/modules/users/controller/user_bloc.dart';
import 'package:bloc_app/modules/users/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: BlocProvider<UserBloc>(
        create: (_) => UserBloc()..add(FetchUsers()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(
                  child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text(state.message),
                ],
              ));
            } else if (state is UserLoaded) {
              List<UserModel> users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar ?? ''),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email ?? ''),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else if (state is UserNetworkError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
