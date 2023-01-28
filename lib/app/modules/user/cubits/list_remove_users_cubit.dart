import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../errors/user_errors.dart';
import '../models/user_model.dart';
import '../repositories/users_repository.dart';

part 'list_remove_users_state.dart';

class ListRemoveUsersCubit extends HydratedCubit<ListRemoveUsersState> {
  final UsersRepository usersRepository;

  ListRemoveUsersCubit(this.usersRepository) : super(const InitialState());

  Future<void> getUsers({String id = ''}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await usersRepository.getUsers(id: id);
      emit(state.copyWith(isLoading: false, users: result));
    } on UserError catch (e) {
      emit(state.copyWith(error: e.message));
    }
  }

  @override
  ListRemoveUsersState? fromJson(Map<String, dynamic> json) {
    final isLoading = json['isLoading'] ?? false;
    final error = json['error'] ?? '';
    final users = UserModel.fromMapList(json['users']);
    return ListRemoveUsersState(isLoading: isLoading, error: error, users: users);
  }

  @override
  Map<String, dynamic>? toJson(ListRemoveUsersState state) {
    final usersJson = state.users.map((e) => e.toMap()).toList();
    return {'isLoading': state.isLoading, 'error': state.error, 'users': usersJson};
  }
}
