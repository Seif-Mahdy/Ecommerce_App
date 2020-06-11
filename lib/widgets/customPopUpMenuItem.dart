import 'package:flutter/material.dart';

class CustomPopUpMenuItem<T> extends PopupMenuItem<T>
{
  final Widget child;
  final Function onclick;
  CustomPopUpMenuItem({@required this.child , @required this.onclick}) : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return CustomPopUpMenuItemState();
  }
}

class CustomPopUpMenuItemState<T,PopUpMenuItem> extends PopupMenuItemState<T,CustomPopUpMenuItem<T>>{

  @override
  void handleTap() {
    widget.onclick();
  }
}