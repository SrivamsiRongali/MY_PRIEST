
import 'package:flutter/material.dart';

import 'flutter_flow/flutter_flow_theme.dart';



class popup extends StatelessWidget {
 popup({required this.onPressed,required this.content,required this.buttontext});
  VoidCallback onPressed;
  String content;
  String buttontext;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor:Colors.grey[200],
                surfaceTintColor: Colors.grey[200],
                actions: [Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed:onPressed,
                              child: Text(
                                '$buttontext',
                                style: TextStyle(
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
                    padding: EdgeInsetsDirectional.fromSTEB(
                        15.0, 40.0, 15.0, 0.0),
                    child: Text(
"$content",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
   popupwithyesandnobuttons({required this.onPressedforyes,required this.onPressedforno,required this.content});
VoidCallback onPressedforyes;
VoidCallback onPressedforno;
String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor:Colors.grey[200],
                surfaceTintColor: Colors.grey[200],
                actions: [Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
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
                    padding: EdgeInsetsDirectional.fromSTEB(
                        15.0, 40.0, 15.0, 0.0),
                    child: Text(
                      '$content',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
   popupwithDiscardandsavebuttons({required this.onPressedfordiscard,required this.onPressedforsave,required this.content});
VoidCallback onPressedfordiscard;
VoidCallback onPressedforsave;
Widget content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor:Colors.grey[200],
                surfaceTintColor: Colors.grey[200],
                actions: [Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
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
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0.0, 40.0, 0.0, 0.0),
                    child: content
                  ),
                ),
              );
  }
}