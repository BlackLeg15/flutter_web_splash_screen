import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_splash_screen/app/core/services/http_client/http_client_dio_imp.dart';
import 'package:flutter_web_splash_screen/app/modules/user/cubits/list_remove_users_cubit.dart';
import 'package:flutter_web_splash_screen/app/modules/user/pages/list_remove_users_page.dart';
import 'package:flutter_web_splash_screen/app/modules/user/repositories/users_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'modules/user/pages/user_menu_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        name: 'User Menu Page',
        builder: (context, state) {
          initUserScopeDependencies();
          return const UserMenuPage();
        },
        routes: [
          GoRoute(
            path: 'list',
            builder: (context, state) {
              GetIt.I.registerSingleton(ListRemoveUsersCubit(GetIt.I()));
              return const ListRemoveUsersPage();
            },
          ),
          GoRoute(
            path: 'add',
            builder: (context, state) {
              //TODO(adbysantos): Create a page for adding users
              return const SizedBox();
            },
          ),
        ]),
  ],
);

void initUserScopeDependencies() {
  GetIt.I.pushNewScope(
    init: (getIt) {
      getIt.registerSingleton(
        UsersRepository(
          HttpClientDioImp(
            Dio(
              BaseOptions(baseUrl: 'https://63d3c5a4a93a149755b25aa3.mockapi.io'),
            ),
          ),
        ),
      );
    },
  );
}
