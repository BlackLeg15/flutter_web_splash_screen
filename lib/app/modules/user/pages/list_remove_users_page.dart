import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../cubits/list_remove_users_cubit.dart';

class ListRemoveUsersPage extends StatefulWidget {
  const ListRemoveUsersPage({super.key});

  @override
  State<ListRemoveUsersPage> createState() => _ListRemoveUsersPageState();
}

class _ListRemoveUsersPageState extends State<ListRemoveUsersPage> {
  final cubit = GetIt.I<ListRemoveUsersCubit>();

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    if (cubit.state.users.isEmpty) {
      cubit.getUsers();
    }
  }

  @override
  void dispose() {
    GetIt.I.unregister<ListRemoveUsersCubit>(
      disposingFunction: (cubit) {
        return cubit.clear().then((value) {
          cubit.close();
        });
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
        actions: [
          BlocBuilder<ListRemoveUsersCubit, ListRemoveUsersState>(
            bloc: cubit,
            builder: (context, state) {
              if (state.isLoading) {
                return const SizedBox();
              }
              return IconButton(
                onPressed: () {
                  refreshKey.currentState?.show();
                },
                icon: const Icon(Icons.refresh),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ListRemoveUsersCubit, ListRemoveUsersState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          late Widget child;
          if (state.error.isNotEmpty) {
            child = Center(
              child: Column(
                children: [
                  BackButton(
                    onPressed: () {
                      context.go('../');
                    },
                  ),
                  Text(state.error),
                ],
              ),
            );
          } else if (state.isLoading) {
            child = const Center(child: CircularProgressIndicator.adaptive());
          } else {
            child = RefreshIndicator(
              key: refreshKey,
              onRefresh: cubit.getUsers,
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    title: Text(user.firstName),
                    subtitle: Text(user.jobTitle),
                  );
                },
              ),
            );
          }
          return child;
        },
      ),
    );
  }
}
