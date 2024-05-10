import 'package:flutter/material.dart';

navigateTo(context, Widget newView) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => newView,
    ),
  );
}

navigateToWithReplacement(context, Widget newView) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => newView,
    ),
  );
}

navigateAndRemoveUntil(context, Widget newView) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => newView,
    ),
    (route) => false,
  );
}
