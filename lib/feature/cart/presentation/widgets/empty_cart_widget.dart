import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/empty_cart_anim.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            repeat: true,
            reverse: false,
            animate: true,
          ),
          const SizedBox(height: 20),
          Text(
            "Cart is empty",
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
