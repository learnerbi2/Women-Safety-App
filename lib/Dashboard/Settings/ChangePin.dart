import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinput/pinput.dart';

class ChangePinScreen extends StatefulWidget {
  final int pin;
  const ChangePinScreen({Key? key, required this.pin}) : super(key: key);

  @override
  _ChangePinScreenState createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final TextEditingController _pinPutController1 = TextEditingController();
  final FocusNode _pinPutFocusNode1 = FocusNode();
  final TextEditingController _pinPutController2 = TextEditingController();
  final FocusNode _pinPutFocusNode2 = FocusNode();
  String currentPin = "";
  bool pinChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              widget.pin == -1111 ? "Create PIN" : "Change PIN",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/pin.png",
              height: 70,
            ),
          ),
          Visibility(
            visible: widget.pin != -1111,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 35.0, right: 20),
                  child: Row(
                    children: [
                      Text("Current Pin"),
                      Expanded(
                        child: Divider(
                          indent: 10,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.all(20.0),
                  child: Pinput(
  length: 4,
  controller: _pinPutController1,
  focusNode: _pinPutFocusNode1,
  onCompleted: (pin) {
    currentPin = pin;
    _pinPutFocusNode1.unfocus();
  },
  defaultPinTheme: PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Colors.black),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15),
    ),
  ),
),

                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 35.0, right: 20),
            child: Row(
              children: [
                Text("New Pin"),
                Expanded(
                    child: Divider(
                  indent: 10,
                  endIndent: 20,
                )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.all(20.0),
            child:Pinput(
  length: 4,
  controller: _pinPutController1,
  focusNode: _pinPutFocusNode1,
  onCompleted: (pin) {
    currentPin = pin;
    _pinPutFocusNode1.unfocus();
  },
  defaultPinTheme: PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Colors.black),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15),
    ),
  ),
),

          ),
          SizedBox(height: 100),
          Visibility(
              visible: pinChanged,
              child: Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Center(
                          child: Text(
                        "Done",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }


  void changePin(int parse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("pin", parse);
  }

  void changePinSnakBar(pin) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 10),
      content: Container(
        height: 20.0,
        child: Center(
          child: Text(
            'Pin Changed. Value: $pin',
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    changePin(int.parse(pin));
    setState(() {
      pinChanged = true;
    });
    _pinPutController1.clear();
    _pinPutController2.clear();
    _pinPutFocusNode1.unfocus();
    _pinPutFocusNode2.unfocus();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
