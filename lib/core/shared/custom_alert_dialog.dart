import 'package:flutter/material.dart';

class CustomAlertDialog {
  customAlert({
    String? title,
    String? body,
    String confirmTitle = 'Confirm',
    String cancelTitle = 'Cancel',
    Color? color,
    BuildContext? context,
    Function? onPress,
  }) {
    return showDialog(
      context: context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.3,
                height: 0.3,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
                child: Text(
                  body ?? '',
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onPress as void Function(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xFF32B17c),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                        child: Text(
                          confirmTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                          ),
                        ),
                        child: Text(
                          cancelTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
