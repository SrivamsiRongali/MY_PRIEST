import 'package:get/get.dart';
import 'package:my_priest/main.dart';

import '../my_bookings/Mybookings.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'success_model.dart';
export 'success_model.dart';

class SuccessWidget extends StatefulWidget {
  const SuccessWidget({super.key});

  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget> {
  late SuccessModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuccessModel());
  }
  var data =  Get.arguments;

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
        Get.offAll(NavBarPage());
        return false;
      },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFF7EA),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF1E2022),
                size: 30.0,
              ),
              onPressed: () async {
               Get.offAll(NavBarPage());
              },
            ),
            title: Text(
              'Success',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Inter',
                    color: const Color(0xFF1E2022),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
           
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 40.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/fi_17999895.png',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Text(
                      'Thank you!',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 28.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 20.0),
                    child: Text(
                      'Order placed successfully.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                          textAlign: TextAlign.center,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                  //   child: Text(
                  //     'Event Date: ${data[0]}, ${data[1]}',
                  //     style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //           fontFamily: 'Inter',
                  //           letterSpacing: 0.0,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //   ),
                  // ),
                  FFButtonWidget(
                    onPressed: () {
                     Get.offAll(const mybookings(),arguments: true);
                    },
                    text: 'Orders',
                    options: FFButtonOptions(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(50.0, 25.0, 50.0, 25.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFFFFF6EA),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Inter Tight',
                            color: const Color(0xFFD66223),
                            letterSpacing: 0.0,
                          ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                        color: Color(0xFFD66223),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
