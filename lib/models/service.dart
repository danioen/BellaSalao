import 'package:flutter/material.dart';

class Service {
  final String id;
  final String name;
  final String description;
  final int durationMinutes;
  final double price;
  final IconData icon;

  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.price,
    required this.icon,
  });
}

const demoServices = <Service>[
  Service(
    id: 'corte_feminino',
    name: 'Corte Feminino',
    description: 'Corte personalizado com lavagem e finalização',
    durationMinutes: 60,
    price: 80,
    icon: Icons.content_cut,
  ),
  Service(
    id: 'corte_masculino',
    name: 'Corte Masculino',
    description: 'Corte moderno com acabamento perfeito',
    durationMinutes: 45,
    price: 50,
    icon: Icons.cut,
  ),
  Service(
    id: 'coloracao',
    name: 'Coloração',
    description: 'Coloração completa com tratamento pós-cor',
    durationMinutes: 120,
    price: 150,
    icon: Icons.brush,
  ),
  Service(
    id: 'mechas',
    name: 'Mechas',
    description: 'Mechas tradicionais ou californianas',
    durationMinutes: 180,
    price: 200,
    icon: Icons.auto_awesome,
  ),
  Service(
    id: 'hidratacao',
    name: 'Hidratação',
    description: 'Tratamento intensivo para cabelos danificados',
    durationMinutes: 90,
    price: 100,
    icon: Icons.waves,
  ),
];
