import 'package:delivery_app/feature/home/domain/entity/menu_entity.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final MenuEntity item;

  const MenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white24,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Row(
            children: [
              ClipOval(child: Image.network(item.url)),
              const SizedBox(width: 20),
              Text(
                item.name,
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          const Icon(Icons.arrow_forward_ios),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
