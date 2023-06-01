import 'package:equatable/equatable.dart';

//creating the events which will be trigged from the UI
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUsers extends UserEvent {
  @override
  List<Object?> get props => [];
}
