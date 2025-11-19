import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _messages = [
    {
      'text': '¡Hola! Soy MentoriA, tu compañero de estudio. ¿Cómo te sientes hoy?',
      'isUser': false,
      'timestamp': '10:30',
    },
  ];

  final Map<String, Map<String, String>> texts = {
    'es': {
      'chatTitle': 'MentoriA',
      'subtitle': 'Tu compañero de estudio',
      'placeholder': 'Escribe tu mensaje...',
      'greeting':
          '¡Hola! Soy MentoriA, tu compañero de estudio. ¿Cómo te sientes hoy?',
    },
    'en': {
      'chatTitle': 'MentoriA',
      'subtitle': 'Your study companion',
      'placeholder': 'Write your message...',
      'greeting':
          'Hello! I\'m MentoriA, your study companion. How are you feeling today?',
    },
  };

  String getText(String key, String language) {
    return texts[language]?[key] ?? '';
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isUser': true,
        'timestamp': _getCurrentTime(),
      });
    });

    _messageController.clear();
    _scrollToBottom();

    // Simular respuesta
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': 'Entiendo, estoy aquí para ayudarte. ¿En qué puedo asistirte?',
            'isUser': false,
            'timestamp': _getCurrentTime(),
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;
        final textColor = isDarkMode ? Colors.white : const Color(0xFF0b1e6b);
        final cardBgColor =
            isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[50];
        final inputBgColor =
            isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[50];
        final borderColor =
            isDarkMode ? Colors.grey[800] : Colors.grey[100];
        final subtextColor =
            isDarkMode ? Colors.grey[500] : Colors.grey[600];

        return Container(
          color: bgColor,
          child: SafeArea(
            child: Column(
              children: [
                // Header Premium
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDarkMode
                          ? [const Color(0xFF1a1a1a), const Color(0xFF2a2a2a)]
                          : [const Color(0xFF8b5cf6).withOpacity(0.08),
                              Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border(
                      bottom: BorderSide(color: borderColor!, width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF8b5cf6),
                                Color(0xFF06b6d4)
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF8b5cf6)
                                    .withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getText('chatTitle', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  getText('subtitle', selectedLanguage),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: subtextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms),

                // Messages List
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUser = message['isUser'];

                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Column(
                            crossAxisAlignment: isUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 4,
                                  left: isUser ? 0 : 8,
                                  right: isUser ? 8 : 0,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.75,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? const Color(0xFF2563eb)
                                      : cardBgColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(20),
                                    topRight: const Radius.circular(20),
                                    bottomLeft: Radius.circular(
                                        isUser ? 20 : 4),
                                    bottomRight: Radius.circular(
                                        isUser ? 4 : 20),
                                  ),
                                  border: !isUser
                                      ? Border.all(
                                          color: borderColor,
                                          width: 1.5,
                                        )
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                        isDarkMode ? 0.15 : 0.06,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  message['text'],
                                  style: GoogleFonts.poppins(
                                    color: isUser
                                        ? Colors.white
                                        : textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  message['timestamp'],
                                  style: GoogleFonts.poppins(
                                    color: subtextColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .slideY(
                            begin: 0.3,
                            duration: 400.ms,
                            delay: Duration(milliseconds: 100 * index),
                          )
                          .fadeIn();
                    },
                  ),
                ),

                // Input Area
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border(
                      top: BorderSide(color: borderColor, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Attachment Button
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? const Color(0xFF1a1a1a)
                              : Colors.grey[100],
                          border: Border.all(
                            color: borderColor,
                            width: 1.5,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: const Color(0xFF8b5cf6),
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Message Input
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            hintText:
                                getText('placeholder', selectedLanguage),
                            hintStyle: GoogleFonts.poppins(
                              color: subtextColor,
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.edit_note,
                              color: subtextColor,
                              size: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color: borderColor,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(
                                color: Color(0xFF8b5cf6),
                                width: 2.5,
                              ),
                            ),
                            filled: true,
                            fillColor: inputBgColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            isDense: true,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Send Button
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8b5cf6),
                              Color(0xFF06b6d4)
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8b5cf6)
                                  .withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _sendMessage,
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}