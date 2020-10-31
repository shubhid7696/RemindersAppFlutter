import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders_app_flutter/configFiles/di/injection.dart';
import 'package:reminders_app_flutter/configFiles/network/error_utils.dart';
import 'package:reminders_app_flutter/constants/app_const.dart';
import 'app_event_listener.dart';
import 'base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget child) builder;
  final Function(T) onVmReady;

  BaseView({this.builder, this.onVmReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();

}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> implements AppEventListener {
  T viewModel = getIt<T>();

  //ErrorUtil _errorUtil = getIt<ErrorUtil>();

  @override
  void initState() {
    super.initState();
    if (widget.onVmReady != null) {
      widget.onVmReady(viewModel);
      viewModel.errorEventListener = this;
      viewModel.navEventListener = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => viewModel,
      // builder: (context) => getIt<T>(),
      child: Consumer<T>(builder: widget.builder),
    );
  }



  @override
  void appEvent(int type, dynamic data) {
    if (type < 499) {// messages events
      switch (type) {
        case SHOW_MSG:
          ErrorUtil().showSnackBar(context, data as String);
          break;
        case SHOW_VALIDATION_MSG:
          ErrorUtil().showValidationSnackBar(context, data as String);
          break;
        case REVIEW_SUBMIT_SUCCESS :
          ErrorUtil().showSuccessSnackBar(context, "Review Submitted");
          break;
      }
    } else if(type >= 499 ){
      switch(type){
        case POP_SCR :
          Navigator.pop(context);
          break;
      }

    }else if (type < 2000) { // api error msg events
      if (data is DioError) {
        switch (type) {
          case API_ERROR: {
            ErrorUtil().handleError(context, data as DioError);
            break;
          }
        }
      } else {
        ErrorUtil().showSnackBar(context, "");
      }
    }
  }


}
