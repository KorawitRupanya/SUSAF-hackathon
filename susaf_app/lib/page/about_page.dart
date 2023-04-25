import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Text(
          'The Sustainability Awareness Framework (SusAF)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'The Sustainability Awareness Framework (SusAF) aims to anticipate the effects of IT products and services. It considers five dimensions of sustainability (social, individual, environmental, economic, and technical) and across three orders of effect (direct, indirect, and systemic). We teach you how to apply it to systems you bring with you or example systems we have as a backup. The take-aways from the tutorial are 1) a concrete method for projecting potential sustainability impacts of a system, 2) a graphical illustration to visualize these impacts, and 3) a structure to communicate sustainability impacts to diverse stakeholders.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 16),
        LinkCard(
          title: 'The Sustainability Awareness Framework (SusAF)',
          description:
              'Speakers: Birgit Penzenstadler (Chalmers Univ., Goteborg, Sweden)',
          url:
              'https://conf.researchr.org/details/RE-2021/RE-2021-tutorialstrack/1/The-Sustainability-Awareness-Framework-SusAF-',
        ),
        SizedBox(height: 16),
        LinkCard(
          title:
              'SusAF Welcomes SusApp: Tool Support for the Sustainability Awareness Framework',
          description:
              'Conference: 2021 IEEE 29th International Requirements Engineering Conference (RE)',
          url:
              'https://www.researchgate.net/publication/356364200_SusAF_Welcomes_SusApp_Tool_Support_for_the_Sustainability_Awareness_Framework',
        ),
        SizedBox(height: 16),
        LinkCard(
          title: 'Flutter Widget Catalog',
          description:
              'Comprehensive catalog of Flutter widgets with examples and source code.',
          url: 'https://flutter.dev/docs/development/ui/widgets',
        ),
        SizedBox(height: 16),
        LinkCard(
          title: 'SusAF - the sustainability awareness framework',
          description: 'The workbook - fill me in step by step',
          url:
              'https://www.suso.academy/en/sustainability-awareness-framework-susaf/',
        ),
        SizedBox(height: 16),
        LinkCard(
          title: 'SusAF - the sustainability awareness framework',
          description: 'Workbook',
          url:
              'https://zenodo.org/record/3676514/files/SusAF%20-%20workbook%20-%20V5%20-%20english%20-%20baseline.pdf?download=1',
        ),
      ],
    );
  }
}

class LinkCard extends StatelessWidget {
  final String title;
  final String description;
  final String url;

  const LinkCard({
    Key? key,
    required this.title,
    required this.description,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => openWebsite(url),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openWebsite(String url) async {
    Uri uri = Uri.parse(url);
    try {
      launchUrl(uri);
    } catch (error) {
      throw 'Could not launch $url';
    }
  }
}
