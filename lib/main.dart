import 'package:flutter/material.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walid Teh - Resume',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E293B),
          surface: const Color(0xFFF8FAFC),
        ),
      ),
      home: const ResumePage(),
    );
  }
}

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  int _zoomPercent = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101319),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final scale = _zoomPercent / 100;
          final scaledPageWidth = 794 * scale;
          final scaledPageHeight = 1123 * scale;
          final pageWidthWithMargin = scaledPageWidth + 20;
          final canvasWidth = constraints.maxWidth > pageWidthWithMargin
              ? constraints.maxWidth
              : pageWidthWithMargin;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: canvasWidth,
              height: constraints.maxHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildZoomControls(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: canvasWidth,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: scaledPageWidth,
                              height: scaledPageHeight,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Transform.scale(
                                  scale: scale,
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 794,
                                    height: 1123,
                                    child: Container(
                                      width: 794,
                                      constraints: const BoxConstraints(
                                        minHeight: 1123,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAF9F6),
                                        borderRadius: BorderRadius.circular(7),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.22,
                                            ),
                                            blurRadius: 24,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          54,
                                          52,
                                          54,
                                          48,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            _buildHeader(),
                                            const SizedBox(height: 20),
                                            _buildContactStrip(),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 28,
                                              ),
                                              child: Divider(
                                                height: 1,
                                                color: Color(0xFFE4DED5),
                                              ),
                                            ),
                                            _buildSummary(),
                                            const SizedBox(height: 32),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      _buildProjectExperienceSection(),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 30),
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      _buildSkillsSection(),
                                                      const SizedBox(
                                                        height: 28,
                                                      ),
                                                      _buildEducationSection(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _changeZoom(int amount) {
    setState(() {
      _zoomPercent = (_zoomPercent + amount).clamp(50, 150).toInt();
    });
  }

  Widget _buildZoomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF22262E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF343943)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Zoom out',
            visualDensity: VisualDensity.compact,
            onPressed: _zoomPercent > 50 ? () => _changeZoom(-10) : null,
            icon: const Icon(Icons.remove, size: 18),
            color: Colors.white,
            disabledColor: Colors.white30,
          ),
          SizedBox(
            width: 54,
            child: Text(
              '$_zoomPercent%',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Zoom in',
            visualDensity: VisualDensity.compact,
            onPressed: _zoomPercent < 150 ? () => _changeZoom(10) : null,
            icon: const Icon(Icons.add, size: 18),
            color: Colors.white,
            disabledColor: Colors.white30,
          ),
          Container(
            width: 1,
            height: 22,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: const Color(0xFF454A53),
          ),
          IconButton(
            tooltip: 'Reset zoom',
            visualDensity: VisualDensity.compact,
            onPressed: _zoomPercent == 100
                ? null
                : () => _changeZoom(100 - _zoomPercent),
            icon: const Icon(Icons.restart_alt, size: 18),
            color: Colors.white,
            disabledColor: Colors.white30,
          ),
        ],
      ),
    );
  }

  // Header, contact row, and summary panel.
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'COMPUTER ENGINEERING',
                style: TextStyle(
                  color: Color(0xFFB15D2B),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Walid Teh',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 40,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF201F1E),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Student',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF8A8178),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Container(
          width: 108,
          height: 108,
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF222222),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/profile.jpg',
              fit: BoxFit.cover,
              semanticLabel: 'Walid Teh',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactStrip() {
    return Wrap(
      spacing: 18,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _buildContactRow(Icons.mail_outline, 'walidteh05@gmail.com'),
        _buildContactRow(Icons.call, '0980149343'),
        _buildContactRow(Icons.location_on, 'Bangkok'),
        _buildContactRow(Icons.open_in_new, 'walid.com'),
        _buildContactRow(Icons.code, 'GitHub: walidteh'),
        _buildContactRow(Icons.camera_alt_outlined, '@wrisz.04'),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF1ECE3),
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(color: Color(0xFFB15D2B), width: 2),
        ),
      ),
      child: const Text(
        'Computer Engineering student with an interest in Web Development and IoT. Experienced in building applications using React, Next.js, and Node.js, with hands-on experience using Docker for application development and deployment.',
        style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF514B45)),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFFB15D2B)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF5A554F), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProjectExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('PROJECT EXPERIENCE'),
        const SizedBox(height: 14),
        _buildProjectItem(
          title: 'Full-Stack Web Application',
          technologies: 'Next.js / React / Supabase',
          details: [
            'Developed a web application using Next.js and React.',
            'Integrated Supabase for database and application data management.',
            'Implemented frontend pages and connected them with backend services.',
          ],
        ),
        const SizedBox(height: 16),
        _buildProjectItem(
          title: 'IoT & Smart Security System',
          technologies: 'ESP32 / RFID / Keypad / OLED',
          details: [
            'Developed an IoT-based smart access and security system using ESP32.',
            'Integrated RFID, keypad, OLED display, servo motor, PIR sensor, LED, and buzzer.',
            'Implemented device control and event-driven system behavior.',
          ],
        ),
        const SizedBox(height: 16),
        _buildProjectItem(
          title: 'E-Commerce Web Application',
          technologies: 'PHP / MySQL / JavaScript',
          details: [
            'Developed a web-based e-commerce system for managing products and purchases.',
            'Implemented user purchase flow, product stock management, and wallet transactions.',
            'Designed database interactions using PHP and MySQL.',
          ],
        ),
        const SizedBox(height: 16),
        _buildProjectItem(
          title: 'Cybersecurity / REST API Project',
          technologies: 'Strapi / PostgreSQL / Docker',
          details: [
            'Developed and tested REST API endpoints using Strapi.',
            'Implemented authentication and security-related features.',
            'Used Docker and PostgreSQL to manage the application environment.',
          ],
        ),
      ],
    );
  }

  // --- ส่วนทักษะความสามารถ (Skills) ---
  Widget _buildSkillsSection() {
    final hardSkills = [
      'JavaScript',
      'PHP',
      'Dart',
      'C/C++',
      'React',
      'Next.js',
      'Node.js',
      'HTML / CSS',
      'MySQL',
      'PostgreSQL',
      'Supabase',
      'Git / GitHub',
      'Docker',
      'REST API',
      'Strapi',
      'ESP32 / Arduino',
    ];

    final softSkills = [
      'Problem Solving',
      'Teamwork',
      'Communication',
      'Adaptability',
      'Attention to Detail',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('HARD SKILLS'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: hardSkills.map(_buildBadge).toList(),
        ),
        const SizedBox(height: 22),
        _buildSectionHeader('SOFT SKILLS'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: softSkills.map(_buildBadge).toList(),
        ),
      ],
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('EDUCATION'),
        const SizedBox(height: 10),
        const Text(
          'Rajamangala University of Technology Phra Nakhon (RMUTP)',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF282522),
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Faculty of Engineering',
          style: TextStyle(fontSize: 11, color: Color(0xFF766F67)),
        ),
        const Text(
          'Computer Engineering',
          style: TextStyle(fontSize: 11, color: Color(0xFF766F67)),
        ),
        const Text(
          '4th Year Student',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFFB15D2B),
          ),
        ),
      ],
    );
  }

  // --- Helper Widgets สำหรับตกแต่ง UI ---
  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            color: Color(0xFF292622),
          ),
        ),
        const SizedBox(height: 7),
        const Divider(height: 1, thickness: 1, color: Color(0xFF514B45)),
      ],
    );
  }

  Widget _buildProjectItem({
    required String title,
    required String technologies,
    required List<String> details,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF282522),
          ),
        ),
        Text(
          technologies,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFFB15D2B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 7),
        ...details.map(_buildBullet),
      ],
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•',
            style: TextStyle(fontSize: 12, color: Color(0xFF514B45)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                height: 1.4,
                color: Color(0xFF5A554F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EBE2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2DACE)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10.5, color: Color(0xFF5B554E)),
      ),
    );
  }
}
