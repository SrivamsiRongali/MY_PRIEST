
import 'package:flutter/material.dart';

import 'flutter_flow/flutter_flow_theme.dart';



class popup extends StatelessWidget {
 popup({super.key, required this.onPressed,required this.content,required this.buttontext});
  VoidCallback onPressed;
  String content;
  String buttontext;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor:Colors.grey[200],
                surfaceTintColor: Colors.grey[200],
                actions: [Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed:onPressed,
                              child: Text(
                                buttontext,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                           
                          ],
                        ),
                      ),],
                content: Container(
                  // width: 300.0,
                  // height: 100.0,
                  decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0, 40.0, 15.0, 0.0),
                    child: Text(
content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              );
  }
}
class popupwithyesandnobuttons extends StatelessWidget {
   popupwithyesandnobuttons({super.key, required this.onPressedforyes,required this.onPressedforno,required this.content});
VoidCallback onPressedforyes;
VoidCallback onPressedforno;
String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor:Colors.grey[200],
                surfaceTintColor: Colors.grey[200],
                actions: [Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: onPressedforyes,
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: onPressedforno,
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),],
                content: Container(
                  // width: 300.0,
                  // height: 100.0,
                  decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0, 40.0, 15.0, 0.0),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              );
  }
}

class popupwithDiscardandsavebuttons extends StatelessWidget {
   popupwithDiscardandsavebuttons({super.key, required this.onPressedfordiscard,required this.onPressedforsave,required this.content});
VoidCallback onPressedfordiscard;
VoidCallback onPressedforsave;
Widget content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor:Colors.grey[200],
                surfaceTintColor: Colors.grey[200],
                actions: [Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: onPressedfordiscard,
                              child: Text(
                                'Discard',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: onPressedforsave,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),],
                content: Container(
                  
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 40.0, 0.0, 0.0),
                    child: content
                  ),
                ),
              );
  }
}

class popupwithcustombuttons extends StatelessWidget {
   popupwithcustombuttons({super.key, required this.onPressedforbutton1,required this.onPressedforbutton2,required this.content,required this.title,required this.button1label,required this.button2label});
VoidCallback onPressedforbutton1;
VoidCallback onPressedforbutton2;
Widget button1label;
Widget button2label;
Widget content;
Widget title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: title),
                backgroundColor:Colors.grey[200],
                surfaceTintColor: Colors.grey[200],
                actions: [Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: onPressedforbutton1,
                              child: 
                                button1label,
                              
                            ),
                            TextButton(
                              onPressed: onPressedforbutton2,
                              child:
                              button2label
                            ),
                          ],
                        ),
                      ),],
                content: Container(
                  
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 0.0),
                    child: content
                  ),
                ),
              );
  }
}