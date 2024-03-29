import 'package:flutter/material.dart';

class LoadingIcon extends Offstage {
  LoadingIcon(bool visible) : super(
    offstage: visible,
    child: new Center(
        child: !visible ? new CircularProgressIndicator(
          value: null,
          strokeWidth: 7.0,
        ) : null
    )
  );
}

class LoadableScreen extends Stack {
  LoadableScreen({bool visible, Widget child}) : super(
    fit: StackFit.passthrough,
    children: [
      child,
      LoadingIcon(visible)
    ]
  );
}
