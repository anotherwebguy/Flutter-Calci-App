import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  String _history = "";
  String _expression = "";
  

  

  void buttonPressed(String buttonText){
    setState(() {
      if(buttonText=="x"){
        _expression+="*";
      }else {
        _expression += buttonText;
      }
    });
  }

  void allclear(String Text){
    setState(() {
      _history="";
      _expression="";
    });
  }

  void clear(String Text){
    setState(() {
      _expression="" ;
    });
  }

  void evaluate(String Text){
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {

      _history = _expression;
      _expression=eval.toString();
    });
  }

  Widget buildButton(String buttonText){
    return SizedBox(
      child: OutlineButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(24.0),
        child: Text(buttonText,
         style: TextStyle(
           fontSize: 20.0,
           fontWeight: FontWeight.bold
         ),
        ),
        onPressed: (){
          buttonPressed(buttonText);
        },

      ),
    );
  }

  Widget buildbutton1(String buttonText){
    return SizedBox(
      width: 65,
      height: 65,
      child: FloatingActionButton(
        
        child: Text(buttonText,
         style: TextStyle(
           fontSize: 24.0,
           fontWeight: FontWeight.bold
           
         ),
        ),
        onPressed: (){
          buttonPressed(buttonText);
        },
        backgroundColor: Color(0xFFFFFFFF),
        foregroundColor: Color(0xFF000000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              child: Text(
                _history,style: TextStyle(fontSize: 20.0,
                   color: Color(0xFF545F61),
                ),
              ),
              alignment: Alignment(1,1),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
                child: Text(_expression,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),)),
            Expanded(child: Divider()),
            Column(
            
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      
                      buildButton("7"),
                      buildButton("8"),
                      buildButton("9"),
                      buildbutton1("/"),
                    ]
              ),
              SizedBox(height: 10,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("4"),
                      buildButton("5"),
                      buildButton("6"),
                      buildbutton1("x"),
                    ]
                ),
                SizedBox(height: 10,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("1"),
                      buildButton("2"),
                      buildButton("3"),
                      buildbutton1("-"),
                    ]
                ),
                SizedBox(height: 10,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("."),
                      buildButton("0"),
                      buildButton("00"),
                      buildbutton1("+"),
                    ]
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     SizedBox(
                          width: 65,
                          height: 65,
                          child: FloatingActionButton(
        
                          child: Text("AC",
                             style: TextStyle(
                             fontSize: 24.0,
                             fontWeight: FontWeight.bold
           
                            ),
                          ),
                         onPressed: (){
                         allclear("AC");
                         },
                         backgroundColor: Color(0xFF6C807F),
                         foregroundColor: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(
                          width: 65,
                          height: 65,
                          child: FloatingActionButton(
        
                          child: Text("C",
                             style: TextStyle(
                             fontSize: 24.0,
                             fontWeight: FontWeight.bold
           
                            ),
                          ),
                         onPressed: (){
                         clear("C");
                         },
                         backgroundColor: Color(0xFF6C807F),
                         foregroundColor: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(
                          width: 65,
                          height: 65,
                          child: FloatingActionButton(
        
                          child: Text("%",
                             style: TextStyle(
                             fontSize: 24.0,
                             fontWeight: FontWeight.bold
           
                            ),
                          ),
                         onPressed: (){
                         buttonPressed("%");
                         },
                         backgroundColor: Color(0xFFFFFFFF),
                         foregroundColor: Color(0xFF000000),
                        ),
                      ),
                     SizedBox(
                          child: FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          padding: EdgeInsets.all(24.0),
                          child: Text("=",
                              style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                            ),
                           ),
                          onPressed: (){
                           evaluate("=");
                          },   
                          color: Color(0xFF3C40C6),
                         ),
                        
                       )
                  ],
                )
              ]
            )
          ],
        ),
      )
    );
  }
}
