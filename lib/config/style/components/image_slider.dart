import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../src/provider/home/image_slider_provider.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      "images/5146211.jpg",
      "images/7804227.jpg",
      "images/8407792.jpg"
    ];

    return Consumer<ImageSliderProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  onPageChanged: (value) {
                    provider.updateCurrentSlide(value);
                  },
                  physics: const ClampingScrollPhysics(),
                  children: images.map((image) {
                    return Image.asset(
                      image,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: provider.currentSlide == index ? 15 : 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: provider.currentSlide == index
                              ? Theme.of(context).colorScheme.surface
                              : Colors.transparent,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3))
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
