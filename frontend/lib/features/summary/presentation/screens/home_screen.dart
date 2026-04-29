import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leksika/core/di/injection_container.dart';
import 'package:leksika/features/summary/domain/entities/document_entity.dart';
import 'package:leksika/features/summary/presentation/bloc/summary_bloc.dart';
import 'package:leksika/features/summary/presentation/bloc/summary_event.dart';
import 'package:leksika/features/summary/presentation/bloc/summary_state.dart';
import 'package:leksika/features/summary/presentation/widgets/bottom_navbar.dart';
import 'package:leksika/shared/widgets/error_widget.dart';
import 'package:leksika/shared/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SummaryBloc>()..add(const FetchDocumentsRequested()),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8FAF2),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/create-rangkuman'),
          backgroundColor: const Color(0xFF006947),
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomNavbar(activeIndex: 0),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreetingSection(),
                _buildMainBanner(),
                _buildHistoryHeader(),
                _buildHistorySection(),
                _buildDailyTarget(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return BlocBuilder<SummaryBloc, SummaryState>(
      builder: (context, state) {
        if (state is SummaryLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: LoadingWidget(message: 'Memuat ringkasan...'),
          );
        }
        if (state is SummaryFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ErrorView(
              message: state.message,
              onRetry: () => context
                  .read<SummaryBloc>()
                  .add(const FetchDocumentsRequested()),
            ),
          );
        }
        if (state is SummaryListLoaded) {
          if (state.documents.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text('Belum ada ringkasan.'),
            );
          }
          final preview = state.documents.take(2).toList();
          return Column(
            children: preview
                .map((doc) => _buildHistoryCardFromDocument(doc))
                .toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF5DEAAB), width: 2),
                ),
                child: const Icon(Icons.person,
                    color: Color(0xFFB0C8BF), size: 22),
              ),
              const SizedBox(width: 10),
              const Text(
                'LEKSIKA',
                style: TextStyle(
                  color: Color(0xFF003D2A),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.notifications_none_outlined,
                color: Color(0xFF006947), size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildMainBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF006947), Color(0xFF00A86B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SELAMAT DATANG KEMBALI,',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Juli',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5A623),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.local_fire_department,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STREAK MERANGKUM',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '7 hari berturut-turut!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 8, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Riwayat Rangkuman',
            style: TextStyle(
              color: Color(0xFF003D2A),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/riwayat'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Lihat semua →',
              style: TextStyle(
                color: Color(0xFF006947),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCardFromDocument(DocumentEntity doc) {
    final title = doc.title.isEmpty ? 'Untitled' : doc.title;
    final desc = doc.summary;
    final time = _formatDate(doc.createdAt);
    const pages = 'Ringkasan';
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/detail',
        arguments: {
          'title': title,
          'pageCount': pages,
          'contents': [
            {
              'subTitle': 'Ringkasan',
              'body': desc,
            }
          ],
        },
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF5EC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                    child: const Icon(Icons.description_outlined,
                      size: 18, color: const Color(0xFF006947)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6AEFB8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'RINGKASAN',
                    style: TextStyle(
                      color: Color(0xFF004D33),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF003D2A),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              desc,
              style: const TextStyle(
                color: Color(0xFF2F6555),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: Color(0xFFDDEDE8)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        size: 13, color: Color(0xFF2F6555)),
                    const SizedBox(width: 4),
                    Text(time,
                        style: const TextStyle(
                            color: Color(0xFF2F6555), fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.description_outlined,
                        size: 13, color: Color(0xFF2F6555)),
                    const SizedBox(width: 4),
                    Text(pages,
                        style: const TextStyle(
                            color: Color(0xFF2F6555), fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Baru saja';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildDailyTarget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF5EC),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 26, 24, 20),
            child: Column(
              children: [
                const Text(
                  'Target Hari Ini',
                  style: TextStyle(
                    color: Color(0xFF006947),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kamu hampir mencapai target belajar harianmu! Buat rangkuman lagi untuk mempertahankan streak.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2F6555),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/create-rangkuman'),
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text(
                    'Lanjut Belajar',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006947),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
