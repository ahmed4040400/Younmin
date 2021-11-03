import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

class SentenceField extends StatelessWidget {
  const SentenceField({
    Key? key,
    this.controller,
    required this.onFeelingChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final dynamic Function(bool) onFeelingChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Enter your sentence",
        suffixIcon: Tooltip(
          message: 'How do you feel about this sentence',
          child: Padding(
            padding: EdgeInsets.all(1.sp),
            child: RollingSwitch.icon(
              initialState: true,
              width: 20.sp,
              onChanged: onFeelingChanged,
              rollingInfoRight: const RollingIconInfo(
                  icon: FontAwesomeIcons.smile,
                  backgroundColor: YounminColors.darkPrimaryColor),
              rollingInfoLeft: const RollingIconInfo(
                icon: FontAwesomeIcons.sadTear,
                backgroundColor: YounminColors.badSentenceColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String quantityHintText = "How many have you heard this from";

class quantityField extends StatefulWidget {
  const quantityField({
    this.controller,
    Key? key,
    required this.onPersonChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final dynamic Function(bool) onPersonChanged;

  @override
  State<quantityField> createState() => _quantityFieldState();
}

class _quantityFieldState extends State<quantityField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly, // Only numbers can be entered
          LengthLimitingTextInputFormatter(4), // only 3 numbers can be entered
        ],
        decoration: InputDecoration(
          hintText: quantityHintText,
          suffixIcon: Tooltip(
            message: "Who said this sentence",
            child: Padding(
              padding: EdgeInsets.all(1.sp),
              child: RollingSwitch.widget(
                initialState: true,
                width: 20.sp,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      quantityHintText = "How many have you said that to";
                    } else {
                      quantityHintText = "How many have you heard this from";
                    }
                  });
                  widget.onPersonChanged(value);
                },
                rollingInfoRight: const RollingWidgetInfo(
                    icon: Text('you'),
                    backgroundColor: YounminColors.darkPrimaryColor),
                rollingInfoLeft: const RollingWidgetInfo(
                  icon: Text('else'),
                  backgroundColor: YounminColors.darkPrimaryColor,
                ),
              ),
            ),
          ),
        ));
  }
}
