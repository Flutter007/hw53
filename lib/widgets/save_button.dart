import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final bool isFetching;
  final void Function() onPressed;
  const SaveButton({
    super.key,
    required this.isFetching,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: isFetching ? null : onPressed,
      child:
          isFetching
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Saving ...'),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: theme.disabledColor,
                      strokeWidth: 3,
                    ),
                  ),
                ],
              )
              : Text('Save Task'),
    );
  }
}
