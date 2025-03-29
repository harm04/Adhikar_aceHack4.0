import 'package:adhikar_acehack4_o/features/home/views/pods_view.dart';
import 'package:flutter/material.dart';

class PodsListView extends StatefulWidget {
  const PodsListView({super.key});

  @override
  State<PodsListView> createState() => _PodsListViewState();
}

class _PodsListViewState extends State<PodsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pods'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 20),
            child: Column(
              children: [
                podsCard(
                    'Freelance & Legal Services',
                    'assets/icons/ic_freelance_services.png',
                    'Find contract-based legal work and collaboration opportunities.',
                    'assets/images/freelance_legal_service.jpg'),
                podsCard(
                    'Criminal & Civil Law',
                    'assets/icons/ic_criminal_law.png',
                    'A space for discussions on litigation, trial strategies, and justice.',
                    'assets/images/civil_and_criminal.jpeg'),
                podsCard(
                    'Corporate & Business Law',
                    'assets/icons/ic_businees_law.png',
                    'Contracts, compliance, and startup legal help.',
                    'assets/images/coperate_and_businees.jpg'),
                podsCard(
                    'Moot Court & Bar Exam Prep',
                    'assets/icons/ic_exam_prep.png',
                    'Law students share resources and preparation strategies.',
                    'assets/images/bar_exam.jpg'),
                podsCard(
                    'Internships & Job Opportunities',
                    'assets/icons/ic_internship_and_job.png',
                    'A hub for legal job postings and career growth.',
                    'assets/images/internship.jpg'),
                podsCard(
                    'Legal Tech & AI',
                    'assets/icons/ic_legal_tech_and_ai.png',
                    'Discuss AI-driven legal research, case predictions, and automation.',
                    'assets/images/law_and_ai.jpg'),
                podsCard(
                    'Case Discussions',
                    'assets/icons/ic_case_discussion.png',
                    'Lawyers and students analyze and debate important legal cases.',
                    'assets/images/case_discussion.jpg'),
                podsCard(
                    'Legal News & Updates',
                    'assets/icons/ic_legal_news_and_updates.png',
                    'Stay updated on major rulings, amendments, and industry trends.',
                    'assets/images/legal_news.jpg'),
                podsCard(
                    'General',
                    'assets/icons/ic_general.png',
                    'For general discussion that don\'t fit in any other pod',
                    'assets/images/general.jpg'),
              ],
            ),
          ),
        ));
  }

  Widget podsCard(String podName, String podImage, String podDescription,
      String podBanner) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: GestureDetector(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PodsView(
            podBanner: podBanner,
            podDescription: podDescription,
            podTitle: podName,
            podimage: podImage,
          );
        })),
        child: Card(
          child: Container(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(
                      podImage,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(podName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(podDescription,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
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
