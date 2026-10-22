import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../widgets/custom_space_button.dart';

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
    // ignore: avoid_print
    print(_nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final shortSide = screenSize.shortestSide;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.cosmicBlue, AppColors.deepSpaceBlue],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.08,
                  vertical: screenSize.height * 0.04,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * 0.05),
                    Icon(
                      Icons.rocket_launch_rounded,
                      size: shortSide * 0.15,
                      color: AppColors.starlightWhite,
                    ),
                    SizedBox(height: screenSize.height * 0.025),
                    Text(
                      'Space Quiz',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.starlightWhite,
                        fontSize: shortSide * 0.08,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.012),
                    Text(
                      'Siap menjelajahi luasnya alam semesta?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.starlightWhite.withValues(alpha: 0.8),
                        fontSize: shortSide * 0.042,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    TextField(
                      controller: _nameController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _startMission(),
                      style: TextStyle(
                        color: AppColors.starlightWhite,
                        fontSize: shortSide * 0.044,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Masukkan nama astronot',
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.starlightWhite.withValues(
                            alpha: 0.75,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
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
    );
  }
}
