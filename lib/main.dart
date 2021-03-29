import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';

void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
String equation = "0";
String result = "0";
double equationFontSize = 38.0;
double resultfontSize=48.0;


  buttonpressed(String bT){
    if(equation.length-1 > 30){

      Fluttertoast.showToast(
          msg: "Don't Enter More then 30 Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 55,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

        equation="0";
    }
    setState(() {
      if(bT=="C"){
        equation ="0";
        result = "0";
        equationFontSize = 38.0;
        resultfontSize=48.0;

      }else if(bT=="⌫"){
        equation = equation.substring(0,equation.length-1);
        equationFontSize = 48.0;
        resultfontSize=38.0;
        if(equation ==  ""){
          equation = "0";

        }
      }
      else if(bT =="="){
        equationFontSize = 38.0;
        resultfontSize=48.0;
        var expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

         try{
           Parser p = Parser();
           Expression exp = p.parse(expression);
           ContextModel cm = ContextModel();
           result = '${exp.evaluate(EvaluationType.REAL, cm)}';
         }catch(e){
           result="Error";
         }
      }else {
        equationFontSize = 48.0;
        resultfontSize=38.0;
        if(equation == "0"){
          equation = bT;
        }
        else{
          equation = equation + bT;
        }
      }
    });

  }


  Widget buildButton (String buttonText,double buttonHeight,Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height*0.1*buttonHeight,
      color: buttonColor,
      child: FlatButton(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: Colors.white,width: 1,
                style: BorderStyle.solid)
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonpressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),

      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator'),),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
           padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
           child: Text(equation,style: TextStyle(fontSize: equationFontSize ),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result,style: TextStyle(fontSize: resultfontSize),),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [

                        buildButton("C", 1, Colors.red),
                        buildButton("⌫", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                      ]

                    ),
                    TableRow(
                        children: [

                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                        ]

                    ),

                    TableRow(
                        children: [

                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                        ]

                    ),
                    TableRow(
                        children: [

                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                        ]

                    ),
                    TableRow(
                        children: [

                          buildButton(".", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54),
                        ]

                    ),

                  ],
                ),
              ),
             Container(
               width: MediaQuery.of(context).size.width*0.25,
               child: Table(
                 children: [
                   TableRow(
                     children: [
                       buildButton("×", 1, Colors.blue),
                     ]
                   ),
                   TableRow(
                       children: [
                         buildButton("-", 1, Colors.blue),
                       ]
                   ),
                   TableRow(
                       children: [
                         buildButton("+", 1, Colors.blue),
                       ]
                   ),
                   TableRow(
                       children: [
                         buildButton("=", 2, Colors.red),
                       ]
                   ),
                 ],
               ),
             )
            ],
          ),
        ],
      ),

    );
  }
}
