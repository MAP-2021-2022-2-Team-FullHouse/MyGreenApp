import 'package:flutter/material.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/enums/dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    /* DialogType.form:  (context, sheetRequest, completer) =>
        _FormDialog(request: sheetRequest, completer: completer), */
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Cool',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Awesome',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Got It!',
                  style: TextStyle(color: Colors.purple, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
  }
}
/* 
class _FormDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormDialog({Key? key, required this.request, required this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: /* Build your dialog UI here */
    );
  }
} */