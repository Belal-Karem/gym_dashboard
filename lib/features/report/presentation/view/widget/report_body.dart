import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/report/presentation/view/widget/custom_dropdown_button.dart';
import 'package:power_gym/features/report/presentation/view/widget/repo_view.dart';

class ReportBody extends StatefulWidget {
  const ReportBody({super.key});

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> attendanceData = [
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
      {'date': '5 November'},
      {'date': '6 November'},
      {'date': '7 November'},
    ];

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CustomDropdownButton(),
          SizedBox(height: 15),
          Expanded(
            child: CustomContainerStatistics(
              padding: 0,
              child: SizedBox(
                height: 300,
                child: GridView.builder(
                  itemCount: attendanceData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    final data = attendanceData[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff141318),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['date'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return RepoView();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xff1B1C20),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text('View Report'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
