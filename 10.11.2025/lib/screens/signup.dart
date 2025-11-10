import 'package:flutter/material.dart';
import '../colors.dart';
import '../widgets/social_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', password = '', confirm = '';
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.paleText,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.pastelPurple,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: AppColors.pastelMint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset('assets/images/logo.png')
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AgendaAí', style: TextStyle(color: AppColors.lightPurple, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Cadastre-se para começar', style: TextStyle(color: AppColors.paleText)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Nome completo'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
                    onSaved: (v) => name = v!.trim(),
                  ),
                  const SizedBox(height: 12),
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
                      if (v.length < 6) return 'Use ao menos 6 caracteres';
                      return null;
                    },
                    onSaved: (v) => password = v!,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    obscureText: hidePassword,
                    decoration: const InputDecoration(hintText: 'Confirmar senha'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirme a senha';
                      return null;
                    },
                    onSaved: (v) => confirm = v ?? '',
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: _submit, child: const Text('Cadastrar')),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Center(child: Text('— ou cadastre com —', style: TextStyle(color: AppColors.paleText))),
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

            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text('Já tem conta? Entrar', style: TextStyle(color: AppColors.lightPurple, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (password != confirm) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Senhas não conferem')));
        return;
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Conta criada'),
          content: Text('Bem-vinda, $name!\nEmail: $email'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
  }
}
