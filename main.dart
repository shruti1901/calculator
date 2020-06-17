import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  String number = '0';
  String result = '0';
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  buttonClick(String buttonText) {
    if (buttonText == 'AC') {
      number = '0';
      result = '0';
      num1 = 0;
      num2 = 0;
      operand = '';
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '/' ||
        buttonText == '*') {
      num1 = double.parse(number);
      operand = buttonText;
      result = '';
    } else if (buttonText == '.') {
      if (result.contains('.')) {
        print('Already contains .');
        return;
      } else {
        result = result + buttonText;
      }
    } else if (buttonText == '=') {
      num2 = double.parse(number);
      if (operand == '+') {
        result = (num1 + num2).toString();
      }
      if (operand == '-') {
        result = (num1 - num2).toString();
      }
      if (operand == '/') {
        result = (num1 / num2).toString();
      }
      if (operand == '*') {
        result = (num1 * num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = '';
    } else {
      result = result + buttonText;
    }
    setState(() {
      number = double.parse(result).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: new Text(
                number,
                style: TextStyle(fontSize: 55),
              ),
            ),
            new Expanded(
              child: new Divider(
                thickness: 2,
              ),
            ),
            new Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                operand,
                style: TextStyle(fontSize: 30),
              ),
            ),
            new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('/'),
                    buildButton('AC'),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('*'),
                    buildButton(''),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('-'),
                    buildButton(''),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    buildButton('.'),
                    buildButton('0'),
                    buildButton(''),
                    buildButton('+'),
                    Expanded(
                      child: new FlatButton(
                        color: Colors.orange,
                        padding: EdgeInsets.all(25),
                        onPressed: () {
                          buttonClick('=');
                        },
                        child: new Text(
                          '=',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(String value) {
    return Expanded(
      child: new OutlineButton(
        padding: EdgeInsets.all(25),
        onPressed: () {
          buttonClick(value);
        },
        child: new Text(
          value,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
