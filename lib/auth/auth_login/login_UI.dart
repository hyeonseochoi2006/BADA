// lib/auth/login_ui.dart
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailCtrl; 
  final TextEditingController pwCtrl; 
  final bool pwVisible; 
  final VoidCallback onTogglePw; 
  final VoidCallback onSubmit; 

  const LoginForm({
    super.key,
    required this.emailCtrl,
    required this.pwCtrl, 
    required this.pwVisible, 
    required this.onTogglePw, 
    required this.onSubmit,  
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('로그인',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        const SizedBox(height: 30),

        // 이메일
        _field(
          controller: emailCtrl,
          label: '이메일',
          icon: Icons.email,
          keyboard: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),

        // 비밀번호
        _field(
          controller: pwCtrl,
          label: '비밀번호',
          icon: Icons.lock,
          obscure: !pwVisible,
          suffix: IconButton(
            icon: Icon(pwVisible ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF3B82F6)),
            onPressed: onTogglePw,
          ),
        ),
        const SizedBox(height: 30),

        // 로그인 버튼
        ElevatedButton(
          onPressed: onSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('로그인', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  TextField _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF3B82F6)),
        suffixIcon: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
