import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String text;

  const LoadingIndicator({super.key, this.text = "Cargando..."});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF8b5cf6),
          ),
          const SizedBox(height: 15),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
