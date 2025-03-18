import 'package:flutter/material.dart';

import '../../../components/small_dot.dart';
import '../../../constants.dart';

class FeaturedItemCard extends StatelessWidget {
  const FeaturedItemCard({
    super.key,
    required this.image,
    required this.press,
    required this.title, required this.isDetailScreen,
  });

  final String image, title;
  final VoidCallback press;
  final bool isDetailScreen;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
          color: titleColor.withOpacity(0.64),
          fontWeight: FontWeight.normal,
        );
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              isDetailScreen ? const SizedBox(height: 8) :const SizedBox(width: 0,),
              isDetailScreen ?
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: titleColor, fontWeight: FontWeight.w500),
              ):
              const SizedBox(width: 0,),
            ],
          ),
        ),
      ),
    );
  }
}
