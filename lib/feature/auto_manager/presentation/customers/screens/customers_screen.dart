import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/customers/customers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/response/customer/customer_model.dart';
import '../../sales/widgets/modal_list_card.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Customers${controller.totalCount.value == 0 ? '' : '(${controller.totalCount.value})'}'),
        ),
      ),
      floatingActionButton: UserPermissions.validator.canCreateCustomer ?FloatingActionButton(
        onPressed: controller.navigateToAddCustomerScreen,
        child: const Icon(IconlyLight.plus),
      ) : null,
      body: Column(
        children: <Widget>[
          _buildCustomerSearchField(context),
          Expanded(
            child: _buildCustomerList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerSearchField(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: AppTextInputField(
        onChanged: controller.onSearchFieldInputChanged,
        hintText: 'Search Customer',
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

  Widget _buildCustomerList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future<void>.sync(() => controller.pagingController.refresh());
      },
      child: PagedListView<int, Customer>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Customer>(
            itemBuilder: (BuildContext context, Customer customer, int index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: <Widget>[
                    Visibility(
                      visible: UserPermissions.validator.canUpdateCustomer,
                      child: SlidableAction(
                        backgroundColor: context.colorScheme.background,
                        icon: IconlyLight.edit,
                        label: 'Edit',
                        onPressed: (BuildContext context) {
                          controller.navigateToUpdateCustomerScreen(customer);
                        },
                      ),
                    ),
                    Visibility(
                      visible: UserPermissions.validator.canDeleteCustomer,
                      child: SlidableAction(
                        backgroundColor: context.colorScheme.background,
                        foregroundColor: Colors.red,
                        icon: IconlyLight.delete,
                        label: 'Delete',
                        onPressed: (BuildContext context) async {
                          await AppDialogs.showDialogWithButtons(
                            context,
                            onConfirmPressed: () =>
                                controller.deleteTheCustomer(customer.id),
                            content: const Text(
                              'Are you sure you want to delete this customer?',
                              textAlign: TextAlign.center,
                            ),
                            confirmText: 'Delete',
                          );
                        },
                      ),
                    ),
                  ],
                ),
                child: _buildCustomersListTile(context, index, customer),
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

  Widget _buildCustomersListTile(
      BuildContext context, int index, Customer customer) {
    return Padding(
      padding: AppPaddings.mH,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              showModalBottomSheet<dynamic>(
                context: context,
                builder: (BuildContext context) => SizedBox(
                  child: _buildCustomerDetailModal(context, customer),
                ),
              );
            },
            title: Text(
              customer.name,
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
                    Text(customer.email ?? 'No Email'),
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
                      customer.phone ?? 'No Phone',
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

  Widget _buildCustomerDetailModal(
    BuildContext context,
    Customer customer,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(title: 'Name', value: customer.name ?? '--'),
            ModalListCard(
              title: 'Email',
              value: customer.email ?? '--',
            ),
            ModalListCard(
              title: 'Phone',
              value: customer.phone ?? '--',
            ),
            ModalListCard(
              title: 'Business',
              value: customer.business ?? '--',
            ),
            ModalListCard(
              title: 'Occupation',
              value: customer.occupation ?? '--',
            ),
            ModalListCard(
              title: 'ID Number',
              value: customer.identificationNumber ?? '--',
            ),
            ModalListCard(
              title: 'Address',
              value: customer.address ?? '--',
            ),
            ModalListCard(
              title: 'Date of Birth',
              value: DataFormatter.formatDateToString(
                  customer.dateOfBirth ?? '--'),
            ),
          ],
        ),
      ),
    );
  }
}
