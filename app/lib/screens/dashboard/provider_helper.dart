import 'package:flutter/material.dart';

class ProviderHelper with ChangeNotifier {
  int pageIndex = 0;
  ProviderHelper(){
    //print("But why?");
  }

  changePageIndex(int number) {
    pageIndex = number;
    notifyListeners();
  }
}
