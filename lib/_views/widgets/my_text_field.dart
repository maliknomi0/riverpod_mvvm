import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/_views/widgets/MyText.dart';
import 'package:riverpordmvvm/providers.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 10.0,
    this.maxLines,
    this.isFilled = true,
    this.filledColor,
    this.focusedFilledColor,
    this.fhintColor,
    this.hintColor,
    this.bordercolor,
    this.isright,
    this.radius = 10,
    this.haveLabel = true,
    this.labelSize,
    this.prefixIcon,
    this.suffixtext,
    this.suffixIcon,
    this.suffixTap,
    this.keyboardType,
    this.showFlag,
    this.labelColor,
    this.labelWeight,
    this.validator,
    this.readOnly,
    this.textColor,
    this.isoptional = false,
    this.fbordercolor,
    this.focusedLabelColor,
    this.useCountryCodePicker = false,
    this.useOutlinedBorder = true,
    this.onTap, // Add this if missing
  });

  final String? label, hint, suffixtext;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? isObSecure,
      isoptional,
      haveLabel,
      isFilled,
      isright,
      useCountryCodePicker,
      showFlag,
      useOutlinedBorder;
  final double? marginBottom;
  final int? maxLines;
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
  final TextInputType? keyboardType;
  final VoidCallback? suffixTap;
  final String? Function(String?)? validator;
  final bool? readOnly;

  final VoidCallback? onTap; // Add this if missing
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField>
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
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeControllerProvider).themeMode;
        final systemIsDark = Theme.of(context).brightness == Brightness.dark;

        final isDarkMode = themeMode == ThemeMode.system
            ? systemIsDark
            : themeMode == ThemeMode.dark;

        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.marginBottom!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.label != null)
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
                              color: isFocused
                                  ? widget.focusedLabelColor
                                  : widget.labelColor,
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
                        decoration: isDarkMode
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: lightAppGradiant,
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: darkAppGradiant,
                                border: Border.all(color: blackColor),
                              ), // ❌ No gradient for light mode
                        child: TextFormField(
                          readOnly: widget.readOnly ?? false,
                          onTap: widget
                              .onTap, // Pass the onTap callback to TextFormField
                          keyboardType: widget.keyboardType,
                          maxLines: widget.maxLines ?? 1,
                          controller: widget.controller,
                          onChanged: widget.onChanged,
                          textInputAction: TextInputAction.next,
                          obscureText: widget.isObSecure!,
                          obscuringCharacter: '*',
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.textColor,
                            fontWeight: FontWeight.w400,
                          ),
                          validator: widget.validator,
                          textAlign: widget.isright == true
                              ? TextAlign.right
                              : TextAlign.left,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            prefixIcon: widget.prefixIcon,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            hintText: widget.hint?.tr(),
                            suffixIcon: widget.suffixIcon != null
                                ? GestureDetector(
                                    onTap: widget.suffixTap,
                                    child: widget.suffixIcon,
                                  )
                                : null,
                            suffixStyle: TextStyle(
                              fontSize: 14,
                              color: isFocused
                                  ? widget.fhintColor
                                  : widget.hintColor,
                            ),
                            suffixText: widget.suffixtext,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: isFocused
                                  ? widget.fhintColor
                                  : widget.hintColor,
                            ),
                            filled: true,
                            fillColor: isFocused
                                ? widget.focusedFilledColor ??
                                      TransparentColor.withOpacity(0.03)
                                : widget.filledColor ?? TransparentColor,
                            enabledBorder: widget.useOutlinedBorder == true
                                ? OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          widget.bordercolor ??
                                          TransparentColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      widget.radius ?? 10,
                                    ),
                                  )
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          widget.bordercolor ??
                                          lightPrimaryColor,
                                      width: 1,
                                    ),
                                  ),
                            focusedBorder: widget.useOutlinedBorder == true
                                ? OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          widget.fbordercolor ??
                                          TransparentColor,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      widget.radius ?? 10,
                                    ),
                                  )
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          widget.bordercolor ??
                                          lightPrimaryColor.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
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
      },
    );
  }
}
