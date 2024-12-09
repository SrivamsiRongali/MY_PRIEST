import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'confirmation_widget.dart' show ConfirmationWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConfirmationModel extends FlutterFlowModel<ConfirmationWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? datetextController1;
  String? Function(BuildContext, String?)? datetextController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? timetextController2;
  String? Function(BuildContext, String?)? timetextController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? address1textController3;
  String? Function(BuildContext, String?)? address1textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? address2textController4;
  String? Function(BuildContext, String?)? address2textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? citytextController5;
  String? Function(BuildContext, String?)? citytextController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? statetextController6;
  String? Function(BuildContext, String?)? statetextController6Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode7;
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    datetextController1?.dispose();

    textFieldFocusNode2?.dispose();
    timetextController2?.dispose();

    textFieldFocusNode3?.dispose();
    address1textController3?.dispose();

    textFieldFocusNode4?.dispose();
    address2textController4?.dispose();

    textFieldFocusNode5?.dispose();
    citytextController5?.dispose();

    textFieldFocusNode6?.dispose();
    statetextController6?.dispose();

    textFieldFocusNode7?.dispose();
    textController7?.dispose();
  }
}
