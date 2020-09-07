
import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier
{
  bool isLoading = false;
  changeIsLoading(bool value){
    isLoading = value;
    notifyListeners();
  }
}