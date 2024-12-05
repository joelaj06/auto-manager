import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../sales/widgets/modal_list_card.dart';
import '../getx/user_account_controller.dart';

class UserAccountScreen extends GetView<UserAccountController> {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'User Accounts${controller.totalCount.value == 0 ? '' : '(${controller.totalCount.value})'}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToAddUserScreen,
        child: const Icon(IconlyLight.plus),
      ),
      body: Column(
        children: <Widget>[
          _buildUserSearchField(context),
          Expanded(
            child: _buildUserList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildUserSearchField(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: AppTextInputField(
        onChanged: controller.onSearchFieldInputChanged,
        hintText: 'Search User',
        onFieldSubmitted: (_) => controller.onSearchQuerySubmitted(),
        suffixIcon: GestureDetector(
          onTap: () {
            controller.onSearchQuerySubmitted();
          },
          child: const Icon(
            IconlyLight.search,
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future<void>.sync(() => controller.pagingController.refresh());
      },
      child: PagedListView<int, User>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<User>(
            itemBuilder: (BuildContext context, User user, int index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: <Widget>[
                    SlidableAction(
                      backgroundColor: context.colorScheme.background,
                      icon: IconlyLight.edit,
                      label: 'Edit',
                      onPressed: (BuildContext context) {
                        controller.navigateToUpdateUserScreen(user);
                      },
                    ),
                    SlidableAction(
                      backgroundColor: context.colorScheme.background,
                      foregroundColor: Colors.red,
                      icon: IconlyLight.delete,
                      label: 'Delete',
                      onPressed: (BuildContext context) {
                        controller.deleteUserAccount(user.id);
                      },
                    ),
                  ],
                ),
                child: _buildUsersListTile(context, index, user),
              );
            },
            firstPageErrorIndicatorBuilder: (BuildContext context) =>
                ErrorIndicator(
              error: controller.pagingController.value.error as Failure,
              onTryAgain: () => controller.pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (BuildContext context) =>
                const EmptyListIndicator(),
            newPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            firstPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
          shrinkWrap: true),
    );
  }

  Widget _buildUsersListTile(BuildContext context, int index, User user) {
    return Padding(
      padding: AppPaddings.mH,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              showModalBottomSheet<dynamic>(
                context: context,
                builder: (BuildContext context) => SizedBox(
                  child: _buildUserDetailModal(context, user),
                ),
              );
            },
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      IconlyLight.message,
                      size: 16,
                    ),
                    const AppSpacing(h: 5),
                    Text(user.email ?? 'No Email'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      IconlyLight.call,
                      size: 16,
                    ),
                    const AppSpacing(h: 5),
                    Text(
                      user.phone ?? 'No Phone',
                    ),
                  ],
                ),
              ],
            ),
            leading: const Icon(IconlyLight.profile),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildUserDetailModal(
    BuildContext context,
    User user,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(
                title: 'Name', value: '${user.firstName} ${user.lastName}'),
            ModalListCard(
              title: 'Email',
              value: user.email ?? '--',
            ),
            ModalListCard(
              title: 'Phone',
              value: user.phone ?? '--',
            ),
          ],
        ),
      ),
    );
  }
}
