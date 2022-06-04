/* import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidthPercentage(context, percentage: 0.04),
      ),
      padding: const EdgeInsets.only(
        top: 32,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 5.0,
          ),
          Text(
            request.title ?? '',
            align: TextAlign.center,
          ),
          verticalSpaceSmall,
          BoxText.body(
            request.description ?? '',
            align: TextAlign.center,
          ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (request.secondaryButtonTitle != null)
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: BoxText.body(
                    request.secondaryButtonTitle!,
                    color: Colors.black,
                  ),
                ),
              TextButton(
                onPressed: () => completer(DialogResponse(confirmed: true)),
                child: BoxText.body(
                  request.mainButtonTitle ?? '',
                  color: kcPrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  screenWidthPercentage(BuildContext context, {required double percentage}) {}
}
 */