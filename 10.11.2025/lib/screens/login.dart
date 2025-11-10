import 'package:flutter/material.dart';
import '../colors.dart';
import '../widgets/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.paleText,
        centerTitle: true,
        title: const Text('AgendaAí'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Text(
              'Bem-vinda de volta',
              style: TextStyle(
                color: AppColors.lightPurple,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 6),
            Text(
              'Faça login para gerenciar seus agendamentos.',
              style: TextStyle(color: AppColors.paleText),
            ),
            const SizedBox(height: 20),

            // Formulário
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Informe o email';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Email inválido';
                      return null;
                    },
                    onSaved: (v) => email = v!.trim(),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => hidePassword = !hidePassword),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Informe a senha';
                      if (v.length < 6) return 'Senha muito curta';
                      return null;
                    },
                    onSaved: (v) => password = v!,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: _submit, child: const Text('Entrar')),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Center(child: Text('— ou entre com —', style: TextStyle(color: AppColors.paleText))),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: SocialButton(icon: Icons.g_mobiledata, label: 'Google')),
                const SizedBox(width: 10),
                Expanded(child: SocialButton(icon: Icons.facebook, label: 'Facebook')),
                const SizedBox(width: 10),
                Expanded(child: SocialButton(icon: Icons.alternate_email, label: 'Twitter')),
              ],
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ainda não tem conta? ", style: TextStyle(color: AppColors.paleText)),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/signup'),
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(color: AppColors.lightPurple, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Login'),
          content: Text('Email: $email\nSenha: ${'*' * password.length}'),
          actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Fechar'))],
        ),
      );
    }
  }
}
