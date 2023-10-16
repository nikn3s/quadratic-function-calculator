// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

void main() {
  runApp(const MyApp ());
}

TextEditingController _valueA = TextEditingController();
TextEditingController _valueB = TextEditingController();
TextEditingController _valueC = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   
        brightness: Brightness.dark,  
        primarySwatch: Colors.blue,   
        textTheme: GoogleFonts.montserratAlternatesTextTheme(),
        useMaterial3: true
      ),
      home: const MainScreen(),
    );
  }
}

num _solution = 0;
num _solution2 = 0;
ValueNotifier<List<num>> solutionNotifier = ValueNotifier<List<num>>([0, 0]);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  List<Widget> pages = [
    Information(),
    GraphPage()
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   
        brightness: Brightness.dark,  
        primarySwatch: Colors.blue,   
        textTheme: GoogleFonts.montserratAlternatesTextTheme(),
        useMaterial3: true
      ),
      home: Scaffold(
        appBar: AppBar( 
          title: const Text("Quadratic Solver",),
          centerTitle: true,
      ),
      body: Center(
        child: pages[_index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int _newIndex) {
          setState(() {
            _index = _newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Calculator"
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_sharp),
            label: "Graph"
            )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children:[
            DrawerHeader(decoration: BoxDecoration(
              gradient: const SweepGradient(colors: [Colors.blue, Colors.lightBlue])
            ),
            child:  Text("TO-DO",
            style: TextStyle(
              color: Colors.white,
              
            ),),
            margin: const EdgeInsets.all(0),
            ),
            ElevatedButton(child: const Text("Linear Graph Visualiser"), onPressed: () {}),
            ElevatedButton(child: const Text("Other Polynomials"), onPressed: () {}),

          ],
        )
      ),
      
      ),
      );
      }}

class Information extends StatelessWidget {
  const Information({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      children: const [
          Text("Enter the values from quadratic equation in the following format", style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text("ax² + bx + c", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text("Where a, b, c are integers or decimal values", style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 50,),
          HomeScreen(),
          CalculateButton(),
          SolutionDisplayer(),
      ],
    )
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10,),
        Expanded(
          child:
         TextField(decoration: const InputDecoration(
            labelText: "Enter a",
            border: OutlineInputBorder(gapPadding: 20),
          ),
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          controller: _valueA,
          style: const TextStyle(color: Colors.white)
          )),

          const SizedBox(width: 10,),
          
          Expanded(
          child:
         TextField(decoration: const InputDecoration(
            labelText: "Enter b",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          controller: _valueB,
          style: const TextStyle(color: Colors.white),
          )),
          
          const SizedBox(width: 10,),
          Expanded(
          child:
          TextField(decoration: const InputDecoration(
            labelText: "Enter c",
            border:  OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          controller: _valueC,
          style: const TextStyle(color: Colors.white),
          )),
          const SizedBox(width: 10,),
      ],
    );
  }
}


num quadraticSolver(a, b, c, Function callback) {
  if (a == 0) {
    Fluttertoast.showToast(msg: "a cannot equal 0");
  } else
    {num bottom = a*2;
    num discriminant = pow(b, 2) - 4*a*c;
    if (discriminant < 0) {
      Fluttertoast.showToast(
          msg: "The equation has no real roots Discriminant: $discriminant",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.blue
        );
    } else if (discriminant == 0) {
      Fluttertoast.showToast(msg: "The equation has equal roots when x = ${-b/bottom} ");
    } else if (discriminant > 0) {
      num discriminant2 = sqrt(discriminant);
      num nosol1 = -b + discriminant2;
      num nosol2 = -b - discriminant2;
      num solution1 = nosol1 / bottom;
      num solution2 = nosol2 / bottom;

      solutionNotifier.value = [solution1, solution2];
    } else {
      print("Some other error");
    }
    }
    return 1;
  }

class CalculateButton extends StatefulWidget {
  const CalculateButton({super.key});

  @override
  State<CalculateButton> createState() => _CalculateButtonState();
}

class _CalculateButtonState extends State<CalculateButton> {
  void updateSolution(num solution1, num solution2) {
    setState(() {
      _solution = solution1;
      _solution2 = solution2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child:FilledButton(onPressed: () {setState(() {
        quadraticSolver(double.parse(_valueA.text), double.parse(_valueB.text), double.parse(_valueC.text), updateSolution);
      });}, 
    style: FilledButton.styleFrom(fixedSize: const Size(150, 70)), 
    child: const Text("Calculate", 
    style: TextStyle(
      fontSize: 16
    )
    ),));
  }
}


class SolutionDisplayer extends StatefulWidget {
  const SolutionDisplayer({super.key});

  @override
  State<SolutionDisplayer> createState() => _SolutionDisplayerState();
}

class _SolutionDisplayerState extends State<SolutionDisplayer> {
  num y = 0;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<num>>(
      valueListenable: solutionNotifier,
      builder: (context, solutions, child)
      {
        return Column( children: [
          Text("x₁: ${solutions[0]}", style: const TextStyle(color: Colors.blue, fontSize: 30),),
          const SizedBox(height: 20,),
          Text("x₂: ${solutions[1]}", style: const TextStyle(color: Colors.blue, fontSize: 30),),
          const SizedBox(height: 20,),
          Text("y: ${_valueC.text}", style: const TextStyle(color: Colors.blue, fontSize: 30))

        ]);
      });
  }
}

class Charts {
  final double x;
  final double y;

  Charts(this.x, this.y);
}

class GraphDrawer extends StatefulWidget {
  const GraphDrawer({super.key});

  @override
  State<GraphDrawer> createState() => _GraphDrawerState();
}

class _GraphDrawerState extends State<GraphDrawer> {

  List<Charts> points = [];
  @override
  void initState() {
    super.initState();
    try
    {double a = double.parse(_valueA.text);
    double b = double.parse(_valueB.text);
    double c = double.parse(_valueC.text);
    if (a >= 0) {
      for (double x = -20; x <= 20; x+=0.25) {
      double y = a*x*x + b*x + c;

      points.add(Charts(x, y));
    }
  }
  else if (a.isNegative) {
      for (double i = 20; i >= -20; i -= 0.25) {
        double j = a*i*i + b*i + c;
        points.add(Charts(i, j));
      }
    } 
    else {
      points.add(Charts(1, 2));
    }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid constant values");
    }
  }
  @override
  Widget build(BuildContext context) {
    //ignore: avoid_print
    print(points.length);
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.white,
      primaryXAxis: NumericAxis( 
        maximum: 20,
        minimum: -20,
        interval: 2,
        enableAutoIntervalOnZooming: true,
        borderColor: Colors.amber,
      ),
      primaryYAxis: NumericAxis(
        maximum: 40,
        minimum: -40,
        interval: 2,
      ),
      series: <ChartSeries>[
        LineSeries<Charts, double>(
          dataSource: points, 
          xValueMapper: (Charts value, _) => value.x, 
          yValueMapper: (Charts value, _) => value.y,
          color: Colors.blue)
      ],
    );
    }
}



class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
          child: GraphDrawer()
      ),
    );
  }
}

