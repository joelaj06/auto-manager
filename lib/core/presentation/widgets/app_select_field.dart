import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide ? _buildWebDropdown(context) : _buildMobileSelect(context);
  }

  // ── Web / tablet: DropdownSearch with inline menu + search ────────────────

  Widget _buildWebDropdown(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLabel(context),
          DropdownSearch<T>(
            selectedItem: _selectedItem.value,
            items: (String filter, _) => widget.options
                .where(
                  (T item) => widget
                  .titleBuilder(context, item)
                  .toLowerCase()
                  .contains(filter.toLowerCase()),
            )
                .toList(),
            compareFn: (T a, T b) => a == b,
            itemAsString: (T item) => widget.titleBuilder(context, item),
            onSelected: (T? item) {
              if (item == null) return;
              _selectedItem.value = item;
              controller.text = widget.titleBuilder(context, item);
              widget.onChanged(item);
            },
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator == null
                ? null
                : (T? item) =>
            item == null ? null : widget.validator!(item),
            enabled: !widget.disabled,
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: null,
                hintText: 'Search...',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.colorScheme.outline,
                    width: 0.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.colorScheme.outlineVariant,
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.colorScheme.primary,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.colorScheme.error,
                    width: 0.5,
                  ),
                ),
                filled: true,
                fillColor: widget.disabled
                    ? context.colorScheme.surfaceContainerHighest
                    : context.colorScheme.surface,
              ),
            ),
            suffixProps: DropdownSuffixProps(
              dropdownButtonProps: DropdownButtonProps(
                iconClosed: Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                iconOpened: Icon(
                  Icons.arrow_drop_up,
                  size: 24,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              fit: FlexFit.loose,
              constraints: const BoxConstraints(maxHeight: 280),
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: context.colorScheme.outlineVariant,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: context.colorScheme.primary,
                      width: 1,
                    ),
                  ),
                ),
              ),
              menuProps: MenuProps(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
                    width: 0.5,
                  ),
                ),
                elevation: 3,
              ),
              itemBuilder: widget.customTitleBuilder != null
                  ? (BuildContext ctx, T item, bool isDisabled, bool isSelected) =>
                  widget.customTitleBuilder!(ctx, item, isSelected)
                  : (BuildContext ctx, T item, bool isDisabled, bool isSelected) =>
                  Container(
                    color: isSelected
                        ? context.colorScheme.primary.withValues(alpha: 0.08)
                        : Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 11,
                    ),
                    child: Text(
                      widget.titleBuilder(ctx, item),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface,
                      ),
                    ),
                  ),
            ),
            dropdownBuilder: widget.customChildBuilder != null
                ? (BuildContext ctx, T? item) =>
                widget.customChildBuilder!(ctx, item)
                : null,
          ),
        ],
      ),
    );
  }

// ── Mobile ─────────────────

  Widget _buildMobileSelect(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLabel(context),
          InkWell(
            onTap: () async {
              await showModalBottomSheet<void>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                builder: (BuildContext context) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight:
                      MediaQuery.of(context).size.height * .4,
                      minHeight:
                      MediaQuery.of(context).size.height * .3,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(70),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: widget.options.isEmpty
                            ? 1
                            : widget.options.length,
                        separatorBuilder: (_, _) =>
                        const Divider(height: 0),
                        itemBuilder:
                            (BuildContext context, int index) {
                          if (widget.options.isEmpty) {
                            return const Center(
                                child: SizedBox.shrink());
                          }
                          final T item = widget.options[index];
                          final bool selected =
                              item == _selectedItem.value;
                          final TextButton childListItem = TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: selected
                                  ? context.colorScheme.primary
                                  .withValues(alpha: 0.2)
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              widget.onChanged(item);
                              _selectedItem.value = item;
                              controller.value = TextEditingValue(
                                text: widget.titleBuilder(
                                    context, item),
                              );
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: AppPaddings.bodyH
                                  .add(AppPaddings.mV),
                              child: widget.customTitleBuilder != null
                                  ? widget.customTitleBuilder!(
                                  context, item, selected)
                                  : Text(
                                widget.titleBuilder(
                                    context, item),
                                style: context.body2.copyWith(
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                  color: context
                                      .colorScheme.primary,
                                ),
                              ),
                            ),
                          );
                          if (index == 0 && widget.header != null) {
                            return Column(
                              children: <Widget>[
                                widget.header!(context),
                                childListItem,
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
                controller.text = item == null
                    ? ''
                    : widget.titleBuilder(context, item);
                return IgnorePointer(
                  child: widget.customChildBuilder != null
                      ? widget.customChildBuilder!(context, item)
                      : AppTextInputField(
                    enabled: !widget.disabled,
                    hideLabel: true,
                    validator: (_) => null,
                    controller: controller,
                    hintText: '',
                    onChanged: (_) {},
                    suffixIcon: widget.showIcon
                        ? const Icon(Icons.arrow_drop_down,
                        size: 30)
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

// ── Shared label ──────────────────────────────────────────────────────────

  Widget _buildLabel(BuildContext context) {
    if (widget.labelText == null && widget.suffixLabel == null) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              widget.labelText!.toTitleCase(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: widget.disabled
                    ? context.colorScheme.inverseSurface
                    : context.colorScheme.onSurface,
              ),
            ),
          ),
        if (widget.suffixLabel != null)
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: widget.suffixLabel!,
          ),
      ],
    );
  }
}
