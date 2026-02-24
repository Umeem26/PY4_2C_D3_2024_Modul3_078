import 'package:flutter/material.dart';
import '../auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data untuk 3 halaman onboarding
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "icon": Icons.menu_book_rounded,
      "title": "Selamat Datang di Logbook",
      "desc": "Catat aktivitas harianmu dengan mudah, cepat, dan rapi.",
    },
    {
      "icon": Icons.security_rounded,
      "title": "Keamanan Terjamin",
      "desc": "Data logbook kamu tersimpan aman secara lokal di dalam perangkatmu.",
    },
    {
      "icon": Icons.analytics_rounded,
      "title": "Pantau Setiap Saat",
      "desc": "Kelola semua catatanmu dengan fitur kategori dan pencarian yang dinamis.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade800, Colors.indigo.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // TOMBOL SKIP DI POJOK KANAN ATAS
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginView()),
                    );
                  },
                  child: const Text(
                    "Lewati",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ),
              
              // KONTEN HALAMAN (Bisa di-swipe)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Jika kamu punya gambar asset, ganti Icon ini dengan Image.asset()
                          Icon(
                            _onboardingData[index]["icon"],
                            size: 120,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 40),
                          Text(
                            _onboardingData[index]["title"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _onboardingData[index]["desc"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // INDIKATOR TITIK (DOTS) & TOMBOL BAWAH
              Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                child: Column(
                  children: [
                    // Indikator Titik
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 10,
                          width: _currentPage == index ? 25 : 10,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? Colors.white : Colors.white38,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Tombol Lanjut / Mulai Sekarang
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _onboardingData.length - 1) {
                          // Jika di halaman terakhir, pergi ke Login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginView()),
                          );
                        } else {
                          // Jika bukan, geser ke halaman berikutnya
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.indigo.shade800,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        _currentPage == _onboardingData.length - 1
                            ? "Mulai Sekarang"
                            : "Lanjut",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}