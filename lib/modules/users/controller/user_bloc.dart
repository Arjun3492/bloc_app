import 'package:bloc_app/modules/users/controller/events/user_events.dart';
import 'package:bloc_app/modules/users/controller/states/user_states.dart';
import 'package:bloc_app/modules/users/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserBloc extends Bloc<UserEvent, UserState> {
  //passing the initial state to the bloc
  UserBloc() : super(UserInitial()) {
    //handling the event [FetchUsers] and passing the state to the BlocBuilder
    on<FetchUsers>(((event, emit) async {
      //emitting the loading state initially as soon as the [FetchUsers] event is triggered
      emit(UserLoading(message: "Data Loading"));
      await getUsers(emit);
    }));
  }

  Future<void> getUsers(Emitter<UserState> emit) async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users'));
      if (response.statusCode == 200) {
        final List userList = jsonDecode(response.body)['data'];
        final users = userList.map((json) => UserModel.fromMap(json)).toList();
        // emitting the loaded state when the data is fetched successfully
        emit(UserLoaded(users: users));
      } else {
        // emitting the error state when the data is not fetched
        emit(UserError(message: 'Failed to fetch users'));
      }
    } catch (e) {
      // emitting the network error state when the network is not available
      emit(UserNetworkError(message: 'Network error'));
    }
  }
}
