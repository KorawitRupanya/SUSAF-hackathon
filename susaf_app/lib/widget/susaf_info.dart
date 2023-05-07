import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SusafInfo extends StatelessWidget {
  const SusafInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: const [
              Icon(
                Icons.energy_savings_leaf,
                color: Color(0xFF69D56D),
                size: 34.0,
              ),
              SizedBox(width: 10),
              Text(
                'What SusAF?',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'SusAF is a Sustainability Awareness Framework that helps to identify the sustainability impacts of IT products and services on the five dimensions of sustainability (social, individual, environmental, economic, and technical) across three orders of effect (direct, indirect, and systemic)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.only(top: 20, bottom: 10),
          //   child: Image.network(
          //       'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn2.iconfinder.com%2Fdata%2Ficons%2Fbasic-ui-flat%2F605%2F147_-_Pie_Chart-1024.png&f=1&nofb=1&ipt=9ace24d826b0c0fefec6b4459abbed851df188e51c74a381b8de1390bb61d0c1&ipo=images'),
          // ),
          Row(
            children: const [
              Icon(
                Icons.devices,
                color: Colors.green,
                size: 34,
              ),
              SizedBox(width: 10),
              Text(
                'How SusAF?',
                maxLines: 2,
                softWrap: false,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'To use the SusAF App, simply follow the instructions step by step. The SusAF AI copilot will assist you throughout the way. Have fun!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Icon(
                Icons.public,
                color: Colors.green,
                size: 34,
              ),
              SizedBox(width: 10),
              Text(
                'Why SusAF?',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'SusAF provides a comprehensive and structured approach to assessing project sustainability, allowing users to identify and address sustainability issues early in the project development process. This can help prevent negative impacts and promote long-term sustainability.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go('/about'),
            child: const Text('Read More...'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
