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

  // DATA UNTUK 3 HALAMAN ONBOARDING
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "image": "assets/notes.png",
      "title": "Catat Setiap Momen",
      "desc": "Simpan dan kelola aktivitas harianmu dengan rapi dalam satu Logbook pintar.",
    },
    {
      "image": "assets/calendar.png",
      "title": "Rencanakan Harimu",
      "desc": "Atur jadwal, buat target, dan pastikan tidak ada tenggat waktu yang terlewat.",
    },
    {
      "image": "assets/bell.png",
      "title": "Selalu Terkendali",
      "desc": "Jangan biarkan tugas penting terlewat. Pantau semuanya dengan mudah dan cepat.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade800, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // ==========================================
            // BLOK 1: 60% ATAS (GRADIEN + GAMBAR NAIK)
            // ==========================================
            Expanded(
              flex: 60, // Area gradien diperluas
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // TOMBOL LEWATI
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginView()),
                            );
                          },
                          child: const Text(
                            "Lewati",
                            style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),

                    // GAMBAR 3D
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
                          return Align(
                            alignment: Alignment.center, // Ikon dinaikkan ke tengah layar atas
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Image.asset(
                                _onboardingData[index]["image"],
                                height: 280, // Ukuran ikon sedikit diperbesar agar lebih tegas
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // BLOK 2: 40% BAWAH (PUTIH + TEKS TURUN)
            // ==========================================
            Expanded(
              flex: 40, // Area putih diturunkan posisinya
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebar isi secara proporsional
                    children: [
                      // AREA TEKS
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                            child: Column(
                              key: ValueKey<int>(_currentPage),
                              mainAxisAlignment: MainAxisAlignment.center, // Teks difokuskan ke tengah area putih
                              children: [
                                const SizedBox(height: 10), // Memberi sedikit jarak atas
                                Text(
                                  _onboardingData[_currentPage]["title"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple.shade800,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _onboardingData[_currentPage]["desc"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // AREA DOTS INDIKATOR & TOMBOL
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
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
                                  height: 8,
                                  width: _currentPage == index ? 24 : 8,
                                  decoration: BoxDecoration(
                                    color: _currentPage == index
                                        ? Colors.deepPurple.shade600
                                        : Colors.deepPurple.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25), // Jarak titik ke tombol

                            // Tombol Lanjut
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_currentPage == _onboardingData.length - 1) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginView()),
                                    );
                                  } else {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple.shade700,
                                  foregroundColor: Colors.white,
                                  elevation: 5,
                                  shadowColor: Colors.deepPurple.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  _currentPage == _onboardingData.length - 1
                                      ? "Mulai Sekarang"
                                      : "Lanjut",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}