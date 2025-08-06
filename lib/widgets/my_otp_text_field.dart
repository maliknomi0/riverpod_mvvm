import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/providers/theme_provider.dart';
import 'package:riverpordmvvm/widgets/my_text.dart';
// import 'package:riverpordmvvm/core/themes/theme_constants.dart'; // Gradient ab use nahi ho raha

class MyotpTextField extends StatefulWidget {
  const MyotpTextField({
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
    this.textColor,
    this.isoptional = false,
    this.fbordercolor,
    this.focusedLabelColor,
    this.useCountryCodePicker = false,
    this.useOutlinedBorder = true,
    this.focusNode, // 👈 added
    this.maxLength, // 👈 added
  });

  final String? label, hint, suffixtext;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode; // 👈 added
  final int? maxLength; // 👈 added
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

  @override
  _MyotpTextFieldState createState() => _MyotpTextFieldState();
}

class _MyotpTextFieldState extends State<MyotpTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _defaultFocusNode;
  final ValueNotifier<bool> _focusNotifier = ValueNotifier<bool>(false);

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _defaultFocusNode = FocusNode();
    (widget.focusNode ?? _defaultFocusNode).addListener(_onFocusChange);

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
    _focusNotifier.value = (widget.focusNode ?? _defaultFocusNode).hasFocus;
  }

  @override
  void dispose() {
    (widget.focusNode ?? _defaultFocusNode).removeListener(_onFocusChange);
    _defaultFocusNode.dispose();
    _focusNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);
        final systemIsDark = Theme.of(context).brightness == Brightness.dark;

        final isDarkMode = themeMode == ThemeMode.system
            ? systemIsDark
            : themeMode == ThemeMode.dark;

        // Remove gradient, use only color
        final boxDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius ?? 25),
          color: widget.filledColor ??
              (isDarkMode ? Colors.grey[900] : Colors.white),
          border: Border.all(
            color: widget.bordercolor ??
                (isDarkMode ? Colors.white30 : Colors.black12),
          ),
        );

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
                        decoration: boxDecoration,
                        child: TextFormField(
                          keyboardType: widget.keyboardType,
                          maxLines: widget.maxLines ?? 1,
                          maxLength: widget.maxLength, // 👈 here
                          controller: widget.controller,
                          onChanged: widget.onChanged,
                          textInputAction: TextInputAction.next,
                          obscureText: widget.isObSecure ?? false,
                          obscuringCharacter: '*',
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.textColor,
                            fontWeight: FontWeight.w400,
                          ),
                          validator: widget.validator,
                          textAlign: widget.isright == true
                              ? TextAlign.right
                              : TextAlign.center,
                          focusNode: widget.focusNode ?? _defaultFocusNode,
                          decoration: InputDecoration(
                            counterText: '', // 👈 hide counter below input
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
                                    Colors.grey.withOpacity(0.03)
                                : widget.filledColor ?? Colors.transparent,
                            enabledBorder: widget.useOutlinedBorder == true
                                ? OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: widget.bordercolor ??
                                          Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      widget.radius ?? 10,
                                    ),
                                  )
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: widget.bordercolor ??
                                          Colors.blue,
                                      width: 1,
                                    ),
                                  ),
                            focusedBorder: widget.useOutlinedBorder == true
                                ? OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: widget.fbordercolor ??
                                          Colors.transparent,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      widget.radius ?? 10,
                                    ),
                                  )
                                : UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: widget.bordercolor ??
                                          Colors.blue.withOpacity(0.3),
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
