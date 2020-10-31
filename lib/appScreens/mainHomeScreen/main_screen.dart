import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminders_app_flutter/appScreens/appDialogs/delete_confirm_dialog.dart';
import 'package:reminders_app_flutter/appScreens/appDialogs/rate_dialog.dart';
import 'package:reminders_app_flutter/configFiles/app_routes.dart';
import 'package:reminders_app_flutter/configFiles/baseFiles/base_view.dart';
import 'package:reminders_app_flutter/dataModels/note_model.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_images.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';
import 'package:reminders_app_flutter/uiComponents/app_loader.dart';
import 'package:reminders_app_flutter/uiComponents/image_widgets.dart';
import 'package:reminders_app_flutter/uiComponents/styles_decorations.dart';

import 'main_view_model.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  MainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      floatingActionButton: FloatingActionButton(
          backgroundColor: accentColor,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addNoteRoute);
          },
          tooltip: 'Add Note',
          child: Icon(
            Icons.add,
            color: whiteColor,
          )),
      body: BaseView<MainViewModel>(
          onVmReady: (viewModel) {
            this.viewModel = viewModel;
          },
          builder: (context, viewModel, child) => Stack(
                children: <Widget>[
                  Visibility(
                    visible: false,//(viewModel.notesList.length == 0 ) ? true : false,
                    child: Center(
                      child: SizedImageWidget(
                          ((MediaQuery.of(context).size.height / 100) * 28.11),
                          ((MediaQuery.of(context).size.height / 100) * 63.21),
                          AppImages.appLogo),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      AppBar(
                          centerTitle: true,
                          title: Text("Reminders"),
                          backgroundColor: primaryColor,
                          actions: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.rate_review),
                              tooltip: 'Rating',
                              onPressed: () {
                                showDialog(context: context,
                                    builder: (context) =>
                                        RateUsDialog((int value){
                                          Navigator.pop(context);
                                          viewModel.submitReview(value);
                                        }));
                              },
                            ),
                          ]),
                      /*Visibility(
                        visible: true,
                        child: Container(
                          width: double.infinity,
                          child: Text("upcoming reminder"),
                        ),
                      ),*/
                      Expanded(
                        child: WatchBoxBuilder(
                            box: viewModel.hiveHelper.hiveBox,
                            builder: (context, hiveBox) {
                              viewModel.setListLength(hiveBox.length);
                              return ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSizeConfig.pv16,
                                      vertical: AppSizeConfig.pv16),
                                  itemCount: hiveBox.length,
                                  itemBuilder: (context, index) {
                                    final note = hiveBox.getAt(index) as NoteModel;
                                    return Container(
                                      margin: EdgeInsets.only(bottom: AppSizeConfig.pv16),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppSizeConfig.pv8,
                                          vertical: AppSizeConfig.pv8),
                                      decoration: BoxDecoration(
                                          color: transparentGray.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(AppSizeConfig.pv8)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  note.title.toString(),
                                                  style: TextStyle(
                                                      color: secondaryDarkColor,
                                                      fontSize:
                                                          AppSizeConfig.font18px,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(width: AppSizeConfig.pv16),
                                              InkWell(
                                                onTap : (){
                                                  showDialog(context: context,
                                                      builder: (context) =>
                                                          DeleteConfirmationDialog((){
                                                            Navigator.pop(context);
                                                            viewModel.deleteReminder(index,note.id);
                                                          }));
                                                },
                                                child: Icon(Icons.delete,color: primaryColor,size: AppSizeConfig.pv24,)),
                                            ],
                                          ),
                                          SizedBox(height: AppSizeConfig.pv8,),
                                          Text(note.descr.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      AppSizeConfig.font14px,
                                                  fontWeight: FontWeight.w300)),
                                          SizedBox(height: AppSizeConfig.pv8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              dateTimeButton(note.selectedDate,0),
                                              SizedBox(width: AppSizeConfig.pv16,),
                                              dateTimeButton(note.selectedTime,1),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text("Repeat : ",style: TextStyle(color: accentColor,fontSize: AppSizeConfig.font15px,fontWeight: FontWeight.w700),),
                                              SizedBox(width: AppSizeConfig.pv8,),
                                              Text(
                                                note.repeatOn == 0 ? "Never" :
                                                  (note.repeatOn == 1 ? "Daily" :
                                                    (note.repeatOn == 2 ? "Weekly" : "Monthly"))
                                                ,style: TextStyle(color: Colors.black,fontSize: AppSizeConfig.font14px),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                      ),
                     /* Visibility(
                        child: AppLoader(),
                        visible: viewModel.isLoading,
                      ),*/
                    ],
                  )
                ],
              )),
    );
  }

  // type is for date and time
  Widget dateTimeButton(String text, int type) {
    return Expanded(
      child: Container(
        height: AppSizeConfig.pv32,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(type == 0 ? Icons.calendar_today : Icons.access_time,color: primaryColor, size: AppSizeConfig.pv16,),
            SizedBox(width: AppSizeConfig.pv8,),
            Text(text, style: TextStyle(
                color: Colors.black,
                fontSize: AppSizeConfig.font14px
            ),),
          ],
        ),
      ),
    );
  }
}
