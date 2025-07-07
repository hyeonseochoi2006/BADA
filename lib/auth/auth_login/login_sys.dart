  // lib/auth/login_sys.dart 로그인 기능 & 입력 검증 
  import 'package:firebase_auth/firebase_auth.dart'; //firebase 기능 불러와 
  import 'package:bada_app/auth/auth_service.dart';

  //로그인 조직 class 
  class LoginSys {
    // 인스턴트를 하나만 공유 
    static final _authService = AuthService();

    /// ① 입력값 검증 → ② Firebase 로그인 → ③ 에러 메시지 반환(null = 성공)
    static Future<String?> signIn(String emailRaw, String pwRaw) async {
      final email = emailRaw.trim(); //trim 으로 공백 제거 
      final pw = pwRaw.trim();

      if (email.isEmpty || pw.isEmpty) {
        return '이메일과 비밀번호를 입력해주세요.';
      }//만약 비어 있으면
      
      try {
        await _authService.signIn(email: email, password: pw); //email pw, 로그인 요청을 보내는 함수 좀 기다려야 돼 
        return null; // 성공
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'user-not-found':
            return '존재하지 않는 사용자입니다.';
          case 'wrong-password':
            return '비밀번호가 틀렸습니다.';
          default:
            return '로그인 실패: ${e.code}';
        }
      } catch (e) {
        return '알 수 없는 오류가 발생했습니다.';
      }
    }
  }

  // 비동기 함수, 잠깐 기다려야 하는 함수, (시간이 좀 걸리는 함수) async 
  // Future<String?> 나중에 string 또는 null 을 하나 줄께라고 약속하는 겍체
  //signIn(String emailRaw, String pwRaw) 매개변수, 로그인에 필요한 이메일과 비범을 외부에서 받아옴 
  //try-catch 는 오류가 날수 있는 코드를 오류가 안나게 감싸줌 
  // try {
  //   // 에러 날 수 있는 코드
  // } catch (e) {
  //   // 에러가 났을 때 대처하는 코드
  // }
  //on FirebaseAuthException catch (e) => firebase 인증에서 로그인 실패 같은 에러가 생겼을때 던지는 예외 
  //e라는 변수에 담는다 e는 안에서 code 는 에러의 종류를 알려주는 문자열 
  //switch (e.code)는 에러 코드 값에 따라 각각 다른 에러 메시지를 선택해서 반환하는 문장이야. 