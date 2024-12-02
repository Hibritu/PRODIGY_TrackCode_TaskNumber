import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp( const RealStopwatchApp());
}

class RealStopwatchApp extends StatelessWidget {
  

 const RealStopwatchApp ({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title:  'Real Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});



  @override

    StopwatchScreenState createState() => StopwatchScreenState();
}



class StopwatchScreenState extends State<StopwatchScreen> {
 final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  String _formattedTime = "00:00:00";

  @override
  void initState() {
    super.initState();
   // Already corrected in your code

    _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
    });
  }

  void _pauseStopwatch() {
    setState(() {
      _stopwatch.stop();
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _formattedTime = "00:00:00";
    });
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _formattedTime = _formatTime(_stopwatch.elapsed);
      });
    }
  }

  String _formatTime(Duration duration) {
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Stopwatch'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Time Display
          Text(
            _formattedTime,
            style: const TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
         const SizedBox(height: 40.0),
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _pauseStopwatch : _startStopwatch,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  backgroundColor: _stopwatch.isRunning ? Colors.orange : Colors.green,
                ),
                child: Text(
                  _stopwatch.isRunning ? "Pause" : "Start",
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
             const  SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _resetStopwatch,
                style: ElevatedButton.styleFrom(
                  padding:const  EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  backgroundColor: Colors.red,
                ),
                child:const Text(
                  "Reset",
                  style:  TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
