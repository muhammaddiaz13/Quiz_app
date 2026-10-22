import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/custom_space_button.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startMission() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      return;
    }

    context.read<QuizProvider>().setUserName(name);
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final shortSide = screenSize.shortestSide.clamp(1.0, 600.0);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(actions: const [ThemeToggleButton()]),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorScheme.surfaceContainerHighest, colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.08,
                      vertical: screenSize.height * 0.035,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenSize.height * 0.025),
                        Image.asset(
                          'assets/images/rocket.png',
                          width: shortSide * 0.2,
                          height: shortSide * 0.2,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: screenSize.height * 0.025),
                        Text(
                          'Space Quiz',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.spaceGrotesk(
                            color: colorScheme.onSurface,
                            fontSize: shortSide * 0.08,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.012),
                        Text(
                          'Siap menjelajahi luasnya alam semesta?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorScheme.onSurface.withValues(alpha: 0.8),
                            fontSize: shortSide * 0.042,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.05),
                        TextField(
                          controller: _nameController,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _startMission(),
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: shortSide * 0.044,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Masukkan nama astronot',
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.75,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.05,
                              vertical: screenSize.height * 0.022,
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.022),
                        CustomSpaceButton(
                          label: 'Mulai Misi',
                          onPressed: _startMission,
                        ),
                        SizedBox(height: screenSize.height * 0.04),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
