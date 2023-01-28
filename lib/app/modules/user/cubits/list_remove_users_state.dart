part of 'list_remove_users_cubit.dart';

class ListRemoveUsersState {
  final bool isLoading;
  final String error;
  final List<UserModel> users;

  const ListRemoveUsersState({
    required this.isLoading,
    required this.error,
    required this.users,
  });

  ListRemoveUsersState copyWith({
    bool? isLoading,
    String? error,
    List<UserModel>? users,
  }) {
    return ListRemoveUsersState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      users: users ?? this.users,
    );
  }
}

class InitialState extends ListRemoveUsersState {
  const InitialState() : super(error: '', isLoading: false, users: const []);
}
