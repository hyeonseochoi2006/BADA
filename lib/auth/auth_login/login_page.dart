// lib/auth/login_page.dart
import 'package:flutter/material.dart';
import 'login_ui.dart'; //ui design 
import 'login_sys.dart'; //system architecture
import 'package:bada_app/auth/auth_signUp/signup_page.dart'; //회원가입 페이지 연결 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override 
  //부모 클래스에서 정의된 메서드를 내 방식으로 바꾼다는 표시야.
  State<LoginPage> createState() => _LoginPageState();
  //"이 화면이 어떻게 반응하고 변화할지 관리를 맡는 객체를 여기서 생성한다."
}

class _LoginPageState extends State<LoginPage> {
  //LoginPage state를 관리하는 클래스야 '_'가 private 다른 파일에는 못씀 
  final _emailCtrl = TextEditingController(); //사용자가 이메일 입력창에 적은 값 
  final _pwCtrl = TextEditingController(); 
  bool _pwVisible = false; //비번을 보여지고 false면 숨겨진다 

  Future<void> _handleLogin() async {
    final error = await LoginSys.signIn(_emailCtrl.text, _pwCtrl.text);
    if (!mounted) return;
    //await를 하다가 위젯이 사라질수도 있습니다, 화면이 아직 살아 있을때만 밑에 있는걸 실행 

    if (error == null) {//성공하면 null를 반환 
      _showSnack('로그인 성공!', const Color(0xFF10B981)); //메세지 툭하고 내려놓음 
      // TODO: Navigator.pushReplacement(HomePage)
    } else {
      _showSnack(error, Colors.red);
    }
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              LoginForm(
                emailCtrl: _emailCtrl,
                pwCtrl: _pwCtrl,
                pwVisible: _pwVisible,
                onTogglePw: () => setState(() => _pwVisible = !_pwVisible),
                onSubmit: _handleLogin,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('계정이 없으신가요?', style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupPage()),
                    ),
                    child: const Text('회원가입', style: TextStyle(color: Color(0xFF1E3A8A))),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
// loginpage 라는 이름의 화면(widget)을 만든다는 뜻이야 
// statefulwiget 상태상속 받았기 때문에 => 변할수 있는 화면 
// 이 위젯은 상태가 바뀔 수 있는 위젯이다! 어떤 클래스의 기능을 "물려받아서" 
// super.key는 부모 클래스(StatefulWidget)에 키를 넘겨주는 거야.
// const 이 위젯이 변하지 않는다면 컴파일 타임에 미리 만들 수 있어서 성능 향상이 돼.
// 이 위젯은 특별한 설정 없이도 쓸 수 있고, 내부 키를 통해 Flutter가 효율적으로 관리할 수 있도록 돕는다."
