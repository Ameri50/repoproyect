import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MentorScreen extends StatelessWidget {
  const MentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Mentores",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MentorCard(
            name: "Dr. Lee",
            specialty: "Matemáticas Avanzadas",
            imageUrl:
                "https://ui-avatars.com/api/?name=Dr+Lee&background=8b5cf6&color=fff",
          ),
          const SizedBox(height: 20),
          MentorCard(
            name: "Laura Castillo",
            specialty: "Productividad & Hábitos",
            imageUrl:
                "https://ui-avatars.com/api/?name=Laura+Castillo&background=06b6d4&color=fff",
          ),
          const SizedBox(height: 20),
          MentorCard(
            name: "Profe Ramírez",
            specialty: "Física y Razonamiento",
            imageUrl:
                "https://ui-avatars.com/api/?name=Profesor+Ramirez&background=ffb703&color=000",
          ),
        ],
      ),
    );
  }
}

class MentorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;

  const MentorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1a1a1a) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              imageUrl,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                specialty,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
