
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const navy = Color(0xFF14213D);
const blue = Color(0xFF2563EB);
const lightBlue = Color(0xFFEFF5FF);
const pageBg = Color(0xFFF7F9FC);
const darkText = Color(0xFF202B3C);
const mutedText = Color(0xFF64748B);

const myEmail = '24wh1a05b7@bvrithyderabad.edu.in';
const myGithub = 'https://github.com/akhila2203';
const myLinkedin =
    'https://www.linkedin.com/in/akhila-anaparthi-71604b363';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akhila Anaparthi | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        fontFamily: 'Arial',
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();

  Future<void> goTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx != null) {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.04,
      );
    }
  }

  Future<void> openResume() async {
    final uri = Uri.base.resolve('assets/assets/resume.pdf');

    try {
      final opened = await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Resume could not be opened. Check assets/resume.pdf.',
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Resume error: $e');
    }
  }

  Future<void> openLink(String link) async {
    final uri = Uri.parse(link);
    try {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } catch (e) {
      debugPrint('Could not open link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _navbar(),
              _hero(),
              _about(),
              _skills(),
              _projects(),
              _education(),
              _certificates(),
              _contact(),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navbar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 650) {
                return Column(
                  children: [
                    const Text(
                      'AKHILA.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: navy,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 2,
                      children: [
                        _navItem('Home', homeKey),
                        _navItem('About', aboutKey),
                        _navItem('Skills', skillsKey),
                        _navItem('Projects', projectsKey),
                        _navItem('Contact', certificatesKey),
                      ],
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  const Text(
                    'AKHILA.',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                      color: navy,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  _navItem('Home', homeKey),
                  _navItem('About', aboutKey),
                  _navItem('Skills', skillsKey),
                  _navItem('Projects', projectsKey),
                  _navItem('Education', educationKey),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => goTo(certificatesKey),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Certificates'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title, GlobalKey key) {
    return TextButton(
      onPressed: () => goTo(key),
      child: Text(
        title,
        style: const TextStyle(
          color: darkText,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _hero() {
    return Container(
      key: homeKey,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF14213D), Color(0xFF203F76)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 65,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final small = constraints.maxWidth < 650;

              final photo = Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF8CB7FF),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/profile.jpeg',
                    width: small ? 145 : 205,
                    height: small ? 145 : 205,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return Container(
                        width: small ? 145 : 205,
                        height: small ? 145 : 205,
                        color: lightBlue,
                        child: const Icon(
                          Icons.person,
                          size: 90,
                          color: navy,
                        ),
                      );
                    },
                  ),
                ),
              );

              final intro = Column(
                crossAxisAlignment: small
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HELLO, WELCOME TO MY PORTFOLIO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9FC2FF),
                      fontSize: 12,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "I'm Akhila Anaparthi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'B.Tech CSE Student | Aspiring Software Developer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFD8E5FA),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'I enjoy building software projects, solving problems, '
                    'and learning technologies that turn ideas into useful solutions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE1EAF8),
                      fontSize: 14,
                      height: 1.9,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton.icon(
                        onPressed: openResume,
                        icon: const Icon(Icons.description_outlined),
                        label: const Text('View My Resume'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: navy,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => goTo(projectsKey),
                        icon: const Icon(Icons.code),
                        label: const Text('Explore Projects'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white70),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18,
                    children: [
                      _socialIcon(
                        Icons.email_outlined,
                        'Email',
                        'mailto:$myEmail',
                      ),
                      _socialIcon(Icons.code, 'GitHub', myGithub),
                      _socialIcon(
                        Icons.work_outline,
                        'LinkedIn',
                        myLinkedin,
                      ),
                    ],
                  ),
                ],
              );

              if (small) {
                return Column(
                  children: [
                    photo,
                    const SizedBox(height: 32),
                    intro,
                  ],
                );
              }

              return Row(
                children: [
                  photo,
                  const SizedBox(width: 55),
                  Expanded(child: intro),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String label, String url) {
    return InkWell(
      onTap: () => openLink(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required GlobalKey key,
    required String eyebrow,
    required String title,
    required Widget child,
    bool white = false,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      color: white ? Colors.white : pageBg,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: const TextStyle(
                  color: blue,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 25),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _about() {
    return _section(
      key: aboutKey,
      eyebrow: 'Get to know me',
      title: 'About Me',
      white: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'I am a Computer Science Engineering student at '
                'BVRIT Hyderabad College of Engineering for Women. '
                'I am interested in software development, web technologies, '
                'and problem-solving.',
                style: TextStyle(
                  fontSize: 15,
                  color: mutedText,
                  height: 1.9,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'My goal is to improve my technical skills by building '
                'practical projects and learning something new every day.',
                style: TextStyle(
                  fontSize: 15,
                  color: mutedText,
                  height: 1.9,
                ),
              ),
              const SizedBox(height: 20),
              const Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _Pill(text: 'Curious Learner'),
                  _Pill(text: 'Teamwork'),
                  _Pill(text: 'Problem Solving'),
                ],
              ),
            ],
          );

          final highlights = Column(
            children: [
              _highlight('2024–2028', 'B.Tech CSE'),
              const SizedBox(height: 14),
              _highlight('8.28 / 10', 'Current CGPA'),
              const SizedBox(height: 14),
              _highlight('Java', 'Programming Language'),
            ],
          );

          if (constraints.maxWidth < 650) {
            return Column(
              children: [
                content,
                const SizedBox(height: 25),
                highlights,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: content),
              const SizedBox(width: 40),
              Expanded(child: highlights),
            ],
          );
        },
      ),
    );
  }

  Widget _highlight(String value, String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE8FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: navy,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: mutedText, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _skills() {
    const skills = [
      ('Java', Icons.code),
      ('HTML', Icons.language),
      ('CSS', Icons.palette_outlined),
      ('Node.js', Icons.dns_outlined),
      ('MySQL', Icons.storage_outlined),
      ('GitHub', Icons.source_outlined),
      ('Excel', Icons.table_chart_outlined),
      ('Problem Solving', Icons.psychology_outlined),
    ];

    return _section(
      key: skillsKey,
      eyebrow: 'What I work with',
      title: 'Technical Skills',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: skills.map((skill) {
          return Container(
            width: 150,
            padding: const EdgeInsets.symmetric(
              vertical: 22,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5EAF2)),
            ),
            child: Column(
              children: [
                Icon(skill.$2, color: blue, size: 30),
                const SizedBox(height: 12),
                Text(
                  skill.$1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _projects() {
    return _section(
      key: projectsKey,
      eyebrow: 'What I have built',
      title: 'Featured Projects',
      white: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth < 600
              ? constraints.maxWidth
              : (constraints.maxWidth - 20) / 2;

          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              SizedBox(
                width: width,
                child: _projectCard(
                  icon: Icons.shield_outlined,
                  number: 'PROJECT 01',
                  title: 'VoiceShield AI',
                  description:
                      'An AI-based prototype designed to analyze voice '
                      'recordings for possible voice cloning and help users '
                      'verify suspicious calls.',
                  tags: ['Python', 'FastAPI', 'AI'],
                ),
              ),
              SizedBox(
                width: width,
                child: _projectCard(
                  icon: Icons.event_available_outlined,
                  number: 'PROJECT 02',
                  title: 'Event Registration Microservice',
                  description:
                      'A software project focused on event registration '
                      'and organizing registration-related functionality.',
                  tags: ['Java', 'Backend', 'APIs'],
                ),
              ),
              SizedBox(
                width: width,
                child: _projectCard(
                  icon: Icons.calculate_outlined,
                  number: 'PROJECT 03',
                  title: 'Simple Calculator',
                  description:
                      'A beginner-friendly application built to practise '
                      'programming fundamentals and basic calculations.',
                  tags: ['Programming', 'Logic'],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _projectCard({
    required IconData icon,
    required String number,
    required String title,
    required String description,
    required List<String> tags,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: pageBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE3E9F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: blue, size: 29),
          ),
          const SizedBox(height: 20),
          Text(
            number,
            style: const TextStyle(
              color: blue,
              letterSpacing: 1.5,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: mutedText,
              fontSize: 13,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: tags.map((tag) => _Pill(text: tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _education() {
    return _section(
      key: educationKey,
      eyebrow: 'My academic journey',
      title: 'Education',
      child: Column(
        children: [
          _educationCard(
            'B.Tech — Computer Science Engineering',
            'BVRIT Hyderabad College of Engineering for Women',
            '2024 – 2028',
            'CGPA: 8.28 / 10',
          ),
          const SizedBox(height: 15),
          _educationCard(
            'Intermediate',
            'Telangana State Residential Junior College (TSRJC)',
            'Completed',
            'Score: 968 / 1000',
          ),
          const SizedBox(height: 15),
          _educationCard(
            'SSC',
            'ZPHS',
            'Completed',
            'Score: 93%',
          ),
        ],
      ),
    );
  }

  Widget _educationCard(
    String degree,
    String school,
    String period,
    String score,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.school_outlined, color: blue, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  school,
                  style: const TextStyle(
                    color: mutedText,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$period  •  $score',
                  style: const TextStyle(
                    color: blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _certificates() {
    return _section(
      key: certificatesKey,
      eyebrow: 'Learning and achievements',
      title: 'Certificates & Achievements',
      white: true,
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _certificate('CodeChef Java', 'java.png'),
          _certificate('CodeChef Data Structures', 'data_structures.png'),
          _certificate('Infosys Springboard', 'infosys.png'),
          _certificate('Deloitte Virtual Experience', 'deloitte.png'),
          _certificate('Smart India Hackathon', 'sih.png'),
        ],
      ),
    );
  }

  Widget _certificate(String title, String file) {
    return SizedBox(
      width: 220,
      child: Container(
        decoration: BoxDecoration(
          color: pageBg,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE5EAF2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Image.asset(
              'assets/certificates/$file',
              height: 145,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) {
                return Container(
                  height: 145,
                  color: lightBlue,
                  child: const Center(
                    child: Icon(
                      Icons.workspace_premium_outlined,
                      color: blue,
                      size: 48,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: navy,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contact() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 55),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [navy, Color(0xFF203F76)],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Column(
            children: [
              const Text(
                'LET’S CONNECT',
                style: TextStyle(
                  color: Color(0xFF9FC2FF),
                  letterSpacing: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Thank you for visiting!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'I am eager to learn, build projects, and grow as a developer.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => openLink('mailto:$myEmail'),
                    icon: const Icon(Icons.email_outlined),
                    label: const Text('Email Me'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: navy,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => openLink(myGithub),
                    icon: const Icon(Icons.code),
                    label: const Text('Visit GitHub'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70),
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => openLink(myLinkedin),
                    icon: const Icon(Icons.work_outline),
                    label: const Text('LinkedIn'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70),
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0C162B),
      padding: const EdgeInsets.all(20),
      child: const Text(
        '© 2026 Akhila Anaparthi • Personal Portfolio',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;

  const _Pill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: blue,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
