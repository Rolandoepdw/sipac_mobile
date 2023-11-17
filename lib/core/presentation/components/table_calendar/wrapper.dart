import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

class Wrapper extends StatelessWidget {
  final Widget? title;
  final Widget child;

  const Wrapper({Key? key, this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(lowPadding),
        height: 160,
        decoration: BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.circular(lowPadding),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Column(
                  children: [
                    title!,
                    const SizedBox(height: lowPadding),
                  ],
                ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
