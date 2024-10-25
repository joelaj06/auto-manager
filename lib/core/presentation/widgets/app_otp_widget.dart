import 'package:flutter/material.dart';

class AppOtp extends StatefulWidget {
  const AppOtp({
    super.key,
    required this.fieldCount,
    required this.onCompleted,
    this.errorColor = Colors.red,
    this.hasError = false, // Added error state here
  });

  final int fieldCount; // Number of OTP fields
  final Color errorColor; // Color for the error state
  final bool hasError; // Error state passed in constructor
  final void Function(String) onCompleted; // Callback for the final OTP string

  @override
  _AppOtpState createState() => _AppOtpState();
}

class _AppOtpState extends State<AppOtp> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List<TextEditingController>.generate(widget.fieldCount, (_) => TextEditingController());
    _focusNodes = List<FocusNode>.generate(widget.fieldCount, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers) {
      controller.dispose();
    }
    for (final FocusNode focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onFieldChanged(int index, String value) {
    if (value.length == 1 && index < widget.fieldCount - 1) {
      // Move to the next field if not the last one
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      // Move to the previous field if empty
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    _checkCompletion();
  }

  void _checkCompletion() {
    final String otp = _controllers.map((TextEditingController controller) => controller.text).join();
    if (otp.length == widget.fieldCount) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(
          widget.fieldCount,
              (int index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  width: 68,
                  height: 64,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    autofocus: index == 0, // Focus on the first field initially
                    onChanged: (String value) => _onFieldChanged(index, value),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: widget.hasError ? widget.errorColor : Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: widget.hasError ? widget.errorColor : Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

