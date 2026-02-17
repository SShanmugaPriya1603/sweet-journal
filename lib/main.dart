import 'package:flutter/material.dart';

void main() {
  runApp(const SymptomStoryApp());
}

class SymptomStoryApp extends StatelessWidget {
  const SymptomStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sweet Journal',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> quotes = [
      "Take a deep breath. You are doing better than you think.",
      "One small step today is enough.",
      "Your feelings are valid.",
      "Rest is productive too.",
      "You survived 100% of your hard days.",
    ];

    final quote = (quotes..shuffle()).first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweet Journal'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDEBFF), // soft pink
              Color(0xFFE3F2FD), // soft blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Daily Quote
                Text(
                  "“$quote”",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                // Welcome Title
                const Text(
                  "Welcome 🌸",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Take a moment for yourself today",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 40),

                // Mood Tracker Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoodScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Mood Tracker',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Breathing Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BreathingScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Breathing Exercise',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  String message = "How are you feeling today?";
  final TextEditingController _journalController = TextEditingController();
  String savedNote = "";

  void updateMood(String mood) {
    setState(() {
      message = mood;
    });
  }

  void saveJournal() {
    if (_journalController.text.isNotEmpty) {
      setState(() {
        savedNote = "Journal saved 💾";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your thoughts are saved 🌸")),
      );

      _journalController.clear();
    }
  }

  Widget moodButton(String emoji, String text, String response) {
    return ElevatedButton(
      onPressed: () => updateMood(response),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text("$emoji  $text"),
    );
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        title: const Text("Mood Tracker"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              // Mood Message Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Select your mood",
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  moodButton("😊", "Happy",
                      "You seem happy today! Keep spreading positivity 💛"),
                  moodButton("😐", "Okay",
                      "A calm day is still a good day 🌿"),
                  moodButton("😢", "Sad",
                      "It's okay to feel sad. You're not alone 💙"),
                  moodButton("😡", "Stressed",
                      "Take a deep breath. You’re doing your best 🌸"),
                ],
              ),

              const SizedBox(height: 35),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Write about your day",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: _journalController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "What made you feel this way today?",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: saveJournal,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Save Note"),
              ),

              const SizedBox(height: 10),

              Text(
                savedNote,
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  String breathingText = "Press Start";
  int selectedSeconds = 60; // default 1 min
  int remainingSeconds = 60;

  bool isRunning = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 150, end: 250).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (!isRunning) return;

      if (status == AnimationStatus.completed) {
        setState(() {
          breathingText = "Exhale";
        });
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          breathingText = "Inhale";
        });
        _controller.forward();
      }
    });
  }

  void startSession() {
    setState(() {
      remainingSeconds = selectedSeconds;
      isRunning = true;
      breathingText = "Inhale";
    });

    _controller.forward();
    startTimer();
  }

  void stopSession() {
    setState(() {
      isRunning = false;
      breathingText = "Session Stopped";
    });

    _controller.stop();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!isRunning) return;

      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
        startTimer();
      } else {
        setState(() {
          breathingText = "Session Complete 💙";
          isRunning = false;
        });
        _controller.stop();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  Widget sessionButton(int seconds, String label) {
    return ElevatedButton(
      onPressed: () {
        if (!isRunning) {
          setState(() {
            selectedSeconds = seconds;
            remainingSeconds = seconds;
          });
        }
      },
      child: Text(label),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Breathing Exercise')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  formatTime(remainingSeconds),
                  style: const TextStyle(fontSize: 26),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sessionButton(60, "1 Min"),
                    const SizedBox(width: 10),
                    sessionButton(180, "3 Min"),
                    const SizedBox(width: 10),
                    sessionButton(300, "5 Min"),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  width: _animation.value,
                  height: _animation.value,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  breathingText,
                  style: const TextStyle(fontSize: 26),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      onPressed: isRunning ? null : startSession,
                      child: const Text("Start"),
                    ),

                    const SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: isRunning ? stopSession : null,
                      child: const Text("Stop"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


