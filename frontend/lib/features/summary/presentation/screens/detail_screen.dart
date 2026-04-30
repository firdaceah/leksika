import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SummaryDetailScreen extends StatelessWidget {
  const SummaryDetailScreen({
    super.key,
    required this.title,
    required this.pageCount,
    required this.contents,
  });

  final String title;
  final String pageCount;
  final List<Map<String, String>> contents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF5EC),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00362A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dibuat dari $pageCount',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2F6555),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Menampilkan daftar kartu konten
                  ...contents.map((data) => _buildContentCard(
                        data['subTitle'] ?? '',
                        data['body'] ?? '',
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF00362A),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Rangkuman',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00362A),
            ),
          ),
          const CircleAvatar(
            backgroundColor: Color(0xFF006947),
            child: Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(String subTitle, String body) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FAF7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFB7EDD9), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00362A),
            ),
          ),
          const Divider(color: Color(0xFFB7EDD9), height: 24),
          MarkdownBody(
            data: body,
            selectable: true, 
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(
                fontSize: 15,
                color: Color(0xFF2F6555),
                height: 1.6,
              ),
              strong: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF00362A),
              ),
              listBullet: const TextStyle(
                color: Color(0xFF006947),
                fontSize: 15,
              ),
              blockSpacing: 12,
            ),
          ),
        ],
      ),
    );
  }
}