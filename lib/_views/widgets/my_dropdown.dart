import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zene/_Controller/theme_Controller.dart';
import 'package:zene/themes/theme_constants.dart';
import 'package:zene/_views/widgets/MyText.dart';

class MyDropdown<T> extends StatefulWidget {
  const MyDropdown({
    super.key,
    this.hint,
    this.label,
    this.onChanged,
    this.marginBottom = 10.0,
    this.isFilled = true,
    this.filledColor,
    this.focusedFilledColor,
    this.fhintColor,
    this.hintColor,
    this.bordercolor,
    this.isright,
    this.radius,
    this.haveLabel = true,
    this.labelSize,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixTap,
    this.showFlag,
    this.labelColor,
    this.labelWeight,
    this.validator,
    this.textColor,
    this.isoptional = false,
    this.fbordercolor,
    this.focusedLabelColor,
    this.isDark = false, // Default to false
    required this.items,
    this.value,
  });

  final String? label, hint;
  final ValueChanged<T?>? onChanged;
  final bool? isoptional, haveLabel, isFilled, isright, showFlag;
  final bool isDark; // <- bool type with default false
  final double? marginBottom;
  final double? labelSize, radius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? filledColor,
      focusedFilledColor,
      focusedLabelColor,
      hintColor,
      bordercolor,
      fbordercolor,
      fhintColor,
      textColor,
      labelColor;
  final FontWeight? labelWeight;
  final VoidCallback? suffixTap;
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>> items;
  final T? value;

  @override
  _MyDropdownState<T> createState() => _MyDropdownState<T>();
}

class _MyDropdownState<T> extends State<MyDropdown<T>>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  final ValueNotifier<bool> _focusNotifier = ValueNotifier<bool>(false);

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  void _onFocusChange() {
    _focusNotifier.value = _focusNode.hasFocus;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _focusNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeController>().themeMode;
    final systemIsDark = Theme.of(context).brightness == Brightness.dark;

    final isDarkMode =
        widget.isDark
            ? true
            : themeMode == ThemeMode.system
            ? systemIsDark
            : themeMode == ThemeMode.dark;

    final dropdownDecoration =
        isDarkMode
            ? BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 25),
              gradient: lightAppGradiant,
            )
            : BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 25),
              gradient: darkAppGradiant,
              border: Border.all(color: blackColor),
            );

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.only(bottom: widget.marginBottom ?? 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.label != null && widget.haveLabel == true)
                ValueListenableBuilder(
                  valueListenable: _focusNotifier,
                  builder: (_, isFocused, child) {
                    return Row(
                      children: [
                        MyText(
                          widget.label?.tr() ?? '',
                          size: widget.labelSize ?? 14,
                          paddingBottom: 8,
                          weight: widget.labelWeight ?? FontWeight.w400,
                          color:
                              isFocused
                                  ? widget.focusedLabelColor ??
                                      Theme.of(context).primaryColor
                                  : widget.labelColor ??
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                        ),
                        if (widget.isoptional == true)
                          const MyText(
                            ' (optional)',
                            size: 12,
                            paddingBottom: 8,
                          ),
                      ],
                    );
                  },
                ),
              ValueListenableBuilder(
                valueListenable: _focusNotifier,
                builder: (_, isFocused, child) {
                  return Container(
                    decoration: dropdownDecoration,
                    child: DropdownButtonFormField<T>(
                      value: widget.value,
                      items: widget.items,
                      onChanged: widget.onChanged,
                      focusNode: _focusNode,
                      validator: widget.validator,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            widget.textColor ??
                            Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.w400,
                      ),
                      isExpanded: true,
                      decoration: InputDecoration(
                        prefixIcon: widget.prefixIcon,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        hintText: widget.hint?.tr(),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color:
                              isFocused
                                  ? widget.fhintColor ??
                                      Theme.of(
                                        context,
                                      ).hintColor.withOpacity(0.7)
                                  : widget.hintColor ??
                                      Theme.of(context).hintColor,
                        ),
                        suffixIcon:
                            widget.suffixIcon != null
                                ? GestureDetector(
                                  onTap: widget.suffixTap,
                                  child: widget.suffixIcon,
                                )
                                : null,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
