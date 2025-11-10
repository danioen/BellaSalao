import 'package:flutter/material.dart';
import '../colors.dart';


class SocialButton extends StatelessWidget {
final IconData icon;
final String label;
final VoidCallback? onPressed;


const SocialButton({super.key, required this.icon, required this.label, this.onPressed});


@override
Widget build(BuildContext context) {
return ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.white,
foregroundColor: AppColors.paleText,
elevation: 0,
side: BorderSide(color: AppColors.lilac),
padding: const EdgeInsets.symmetric(vertical: 12),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
),
onPressed: onPressed ?? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entrar com $label (demo)'))),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(icon, size: 20, color: AppColors.lightPurple),
const SizedBox(width: 8),
Text(label, style: TextStyle(color: AppColors.paleText)),
],
),
);
}
}