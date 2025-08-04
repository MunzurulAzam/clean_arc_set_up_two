import 'dart:developer';

import 'package:flutter/foundation.dart';

logMessage(Object message, {String? name}) {
  if (kDebugMode) {
    log('');
    log('-------------------- log message --------------------');
    log(message.toString(), name: name ?? 'log');
    log('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    log('');
  }
}