import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/configFiles/baseFiles/base_view.dart';
import 'package:reminders_app_flutter/constants/app_const.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';
import 'package:reminders_app_flutter/uiComponents/button_widgets.dart';
import 'package:reminders_app_flutter/uiComponents/styles_decorations.dart';
import 'package:reminders_app_flutter/uiComponents/text_widgets.dart';
import 'package:reminders_app_flutter/utils/app_logs.dart';
import 'package:reminders_app_flutter/utils/app_validations.dart';
import 'package:reminders_app_flutter/utils/date_time_util.dart';
import 'add_note_view_model.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> _menuItemKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descrController = TextEditingController();
  final FocusNode _descrNode = FocusNode();

  AddNoteViewModel viewModel;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: whiteColor,
              size: AppSizeConfig.pv32,
            )),
        centerTitle: true,
        title: Text("Add Reminder"),
        backgroundColor: primaryColor,
      ),
      body: BaseView<AddNoteViewModel>(
        onVmReady: (viewModel) {
          this.viewModel = viewModel;
          ALog.d("=================================","t${tz.local}");
        },
        builder: (context, viewModel, child) => ListView(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizeConfig.pv10, vertical: AppSizeConfig.pv10),
          children: <Widget>[
            noteLabelText("Title"),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: AppSizeConfig.pv10,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizeConfig.pv20,
              ),
              child: TextFormField(
                controller: _titleController,
                maxLength: 60,
                style: textInputStyle(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_descrNode);
                },
                validator: (input) {
                  return nameValidation(input);
                },
                decoration: inputDecorationField('Note Title'),
              ),
              decoration: inputFieldBoxDecoration(),
            ),
            noteLabelText("Description"),
            Container(
              constraints: BoxConstraints(maxHeight: AppSizeConfig.pv120),
              margin: EdgeInsets.symmetric(
                vertical: AppSizeConfig.pv10,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizeConfig.pv20,
              ),
              child: TextFormField(
                focusNode: _descrNode,
                controller: _descrController,
                maxLength: 250,
                style: textInputStyle(),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: inputDecorationField('Note Description'),
              ),
              decoration: inputFieldBoxDecoration(),
            ),
            SizedBox(height: AppSizeConfig.pv4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                dateTimeButton((){
                  getDate();
                },viewModel.selectedDate,0),
                SizedBox(width: AppSizeConfig.pv12,),
                dateTimeButton((){
                  getTime();
                },viewModel.selectedTime,1)
              ],
            ),
            SizedBox(height: AppSizeConfig.pv16,),
            ClipRRect(
                borderRadius: BorderRadius.circular(AppSizeConfig.pv8),
                child: repeatSelection(viewModel.repeatTypeSelected)
            ),
            SizedBox(height: AppSizeConfig.pv16,),
            primaryButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  viewModel.addNote(
                    _titleController.text,
                    _descrController.text,
                  );
                },
                label: "Add Note"),
          ],
        ),
      ),
    );
  }

  getTime() async {
    // var item = viewModel.restaurantTimingList[index];
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    );
    if (pickedTime != null) {
      var time = DateFormat(DateTimeUtil.TIME_FORMAT1)
          .format(DateTime(0, 0, 0, pickedTime.hour, pickedTime.minute));
      // ALog.d("##### Date time Util ", "PICKED TIME  ==> "+pickedTime.hour.toString()+":"+pickedTime.minute.toString());
      ALog.d("##### Date time Util ", "PICKED TIME  ==> " + time);

      viewModel.setTiming(time);
    }
  }

  getDate() async {
    // var item = viewModel.restaurantTimingList[index];
    var pickedTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 50),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (pickedTime != null) {
      var date = DateFormat(DateTimeUtil.DATE_FORMAT1)
          .format(DateTime(pickedTime.year, pickedTime.month, pickedTime.day,0, 0, 0));
      // ALog.d("##### Date time Util ", "PICKED TIME  ==> "+pickedTime.hour.toString()+":"+pickedTime.minute.toString());
      ALog.d("##### Date time Util ",
          "PICKED TIME ${pickedTime.month} day ${pickedTime.day}  ==> " + date);

      viewModel.setDate(date);
    }
  }

  // type is for date and time
  Widget dateTimeButton(GestureTapCallback onPressed, String text, int type) {
    return Expanded(
      child: InkWell(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
          onPressed.call();
          },
        child: Container(
          height: AppSizeConfig.pv32,
          decoration: inputFieldBoxDecoration(),
          padding: EdgeInsets.only(left: AppSizeConfig.pv8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(type == 0 ? Icons.calendar_today : Icons.access_time,color: primaryColor, size: AppSizeConfig.pv20,),
              SizedBox(width: AppSizeConfig.pv8,),
              Text(text, style: TextStyle(
                color: Colors.black,
                fontSize: AppSizeConfig.font16px
              ),),
            ],
          ),
        ),
      ),
    );
  }

  Widget repeatSelection(int repeatSelectionType) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        selectionContainer(repeatSelectionType == 1 ? true : false , "Daily",REPEAT_DAILY),
        selectionContainer(repeatSelectionType == 2 ? true : false , "Weekly",REPEAT_WEEKLY),
        selectionContainer(repeatSelectionType == 3 ? true : false , "Monthly",REPEAT_MONTHLY),
      ],
    );
  }

  Widget selectionContainer( bool isSelected, String text, int type){
    return Expanded(
      child: InkWell(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
          viewModel.setRepeatTypeSelected(type);
          },
        child: Container(
          height: AppSizeConfig.pv32,
          color: isSelected ? accentColor : transparentGray,
          child: Center(
            child: Text(text,style: TextStyle(
              color: Colors.black,
              fontSize: AppSizeConfig.font16px,
              fontWeight: FontWeight.w600
            ),)
          ),
        ),
      ),
    );
  }
}
