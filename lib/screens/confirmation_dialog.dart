import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

confirmationDialog(BuildContext context,  String mainText, String subText, String yesButton, VoidCallback onTapCallback) {
  return showGeneralDialog<void>(
    context: context,
    barrierLabel: '',
    barrierColor: Colors.grey.withValues(alpha: 0.5),
    barrierDismissible: false,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return LayoutBuilder(builder: (context, constraints) {
        double containerWidth = constraints.maxWidth * 0.85;

        return Align(
          alignment: Alignment.center,
          child: Container(
            width: containerWidth,
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        CircleAvatar(
                          backgroundColor: Colors.red.withValues(alpha: 0.1),
                          radius: 50,
                          child: Icon(Icons.warning , color: Colors.red, size: 45),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(text: mainText, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: subText.isEmpty ? '' : '\n$subText',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Center(
                                    child: Text('Cancel',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: onTapCallback,
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.1),
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Center(
                                    child: Text(yesButton,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    },
  ).then((value) {
    FocusScope.of(context).unfocus();
  });
}