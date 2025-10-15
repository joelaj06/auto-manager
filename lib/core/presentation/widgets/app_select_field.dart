import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '/core/core.dart';

class AppSelectField<T> extends StatefulWidget {
  const AppSelectField({
    super.key,
    required this.onChanged,
    this.value,
    this.validator,
    this.showIcon = true,
    this.labelText,
    required this.options,
    required this.titleBuilder,
    this.customChildBuilder,
    this.customTitleBuilder,
    this.disabled = false,
    this.header,
    this.suffixLabel,
  });
  final void Function(T) onChanged;
  final T? value;
  final String? labelText;
  final bool showIcon;
  final bool disabled;
  final List<T> options;
  final String? Function(T)? validator;
  final String Function(
    BuildContext,
    T,
  ) titleBuilder;
  final Widget Function(BuildContext, T?)? customChildBuilder;
  final Widget Function(BuildContext, T?, bool isActive)? customTitleBuilder;
  final Widget Function(BuildContext)? header;
  final Widget? suffixLabel;

  @override
  _AppSelectFieldState<T> createState() => _AppSelectFieldState<T>();
}

class _AppSelectFieldState<T> extends State<AppSelectField<T>> {
  late final ValueNotifier<T?> _selectedItem;
  late final TextEditingController controller;

  @override
  void initState() {
    _selectedItem = ValueNotifier<T?>(widget.value);
    controller = TextEditingController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSelectField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedItem.value = widget.value;
      controller.value = widget.value == null
          ? TextEditingValue.empty
          : TextEditingValue(
              text: widget.titleBuilder(context, widget.value as T));
    }
  }

  @override
  void dispose() {
    _selectedItem.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (widget.labelText != null)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.labelText!.toTitleCase(),
                    textAlign: TextAlign.left,
                    style:  TextStyle(
                      fontWeight: FontWeight.w500,
                      color: widget.disabled
                          ? context.colorScheme.inverseSurface
                          : context.colorScheme.onSurface,
                    ),
                  ),
                ),
              if (widget.suffixLabel != null) Padding(
                padding: const EdgeInsets.all(6.0),
                child: widget.suffixLabel!,
              ),
            ],
          ),

          InkWell(
            onTap: () async {
              await showModalBottomSheet<void>(
                //  bounce: true,
                // animationCurve: Curves.fastLinearToSlowEaseIn,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                builder: (BuildContext context) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .4,
                      minHeight: MediaQuery.of(context).size.height * .3,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(70),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        //  controller: ModalScrollController.of(context),
                        itemCount:
                            widget.options.isEmpty ? 1 : widget.options.length,
                        separatorBuilder: (_, __) => const Divider(height: 0),
                        itemBuilder: (BuildContext context, int index) {
                          if (widget.options.isEmpty) {
                            return const Center(
                              child: SizedBox.shrink(),
                            );
                          }
                          final T item = widget.options[index];
                          final bool selected = item == _selectedItem.value;
                          final TextButton childListItem = TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: selected
                                  ? context.colorScheme.primary.withOpacity(0.2)
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              widget.onChanged(item);
                              _selectedItem.value = item;
                              controller.value = TextEditingValue(
                                  text: widget.titleBuilder(context, item));
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: AppPaddings.bodyH.add(AppPaddings.mV),
                              child: widget.customTitleBuilder != null
                                  ? widget.customTitleBuilder!(
                                      context, item, selected)
                                  : Text(
                                      widget.titleBuilder(context, item),
                                      style: context.body2.copyWith(
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.w300,
                                        color:  context.colorScheme.primary,
                                      ),
                                    ),
                            ),
                          );
                          if (index == 0 && widget.header != null) {
                            return Column(
                              children: <Widget>[
                                widget.header!(context),
                                childListItem
                              ],
                            );
                          }

                          return childListItem;
                        },
                      ),
                    ),
                  );
                },
                context: context,
              );
            },
            child: ValueListenableBuilder<T?>(
              valueListenable: _selectedItem,
              builder: (BuildContext context, T? item, _) {
               controller.text =  item == null
                    ? ''
                    : widget.titleBuilder(context, item);
                return IgnorePointer(
                  child: widget.customChildBuilder != null
                      ? widget.customChildBuilder!(context, item)
                      : AppTextInputField(
                          enabled: !widget.disabled,
                          hideLabel: true,
                          validator: (_) {
                            return null;
                          },
                         /* initialValue: item == null
                              ? ''
                              : widget.titleBuilder(context, item),*/
                          controller: controller,
                          /*initialValue: controller.text.isEmpty
                              ? (item == null
                                  ? ''
                                  : widget.titleBuilder(context, item))
                              : null,*/
                          /*controller:
                              controller,*/
                           hintText: '',
                          onChanged: (_) {},
                          suffixIcon: widget.showIcon
                              ? const Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                  // color: context.colors.text,
                                )
                              : null,
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
