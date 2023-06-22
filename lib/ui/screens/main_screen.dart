import 'package:flutter/material.dart';
import 'package:mauth_refresh_token/core/utils/cache/cache_manager.dart';
import 'package:mauth_refresh_token/core/utils/globals/extensions.dart';
import 'package:mauth_refresh_token/core/utils/globals/navigations.dart';
import 'package:mauth_refresh_token/core/viewmodels/auth/user_provider.dart';
import 'package:mauth_refresh_token/ui/routes/route_list.dart';
import 'package:mauth_refresh_token/ui/widgets/custom/custom_image.dart';
import 'package:mauth_refresh_token/ui/widgets/custom/custom_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _refreshController = RefreshController();

  Future<void> refreshHome() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      context.read<UserProvider>().authProfile();
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await refreshHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              await CacheManager.instance.clear().showAdaptiveDialog(context);
              navigate.pushToReplacement(AppRoute.routeLogin);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Consumer<UserProvider>(builder: (context, userProv, child) {
          if (userProv.userProfile == null) {
            return const AdaptiveProgressIndicator();
          }

          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              refreshHome();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CustomImage(url: userProv.userProfile?.avatar),
                ),
                const SizedBox(height: 10),
                Text('ID : ${userProv.userProfile?.id}'),
                const SizedBox(height: 10),
                Text('Name : ${userProv.userProfile?.name}'),
                const SizedBox(height: 10),
                Text('Email : ${userProv.userProfile?.email}'),
                const SizedBox(height: 10),
                Text('Role : ${userProv.userProfile?.role}'),
              ],
            ),
          );
        }),
      ),
    );
  }
}
