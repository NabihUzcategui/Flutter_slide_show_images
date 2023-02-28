import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_show/src/widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade100,
        body: Column(
          children: const [
            Expanded(child: MiSlideShow()),
            Expanded(child: MiSlideShow()),
          ],
        ));
  }
}

class MiSlideShow extends StatelessWidget {
  const MiSlideShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Slideshow(
      bulletBig: 20,
      bulletSmall: 12,
      bulletPrimario: Colors.red,
      bulletSecundario: Colors.pink.shade200,
      puntosArriba: false,
      slides: [
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
    );
  }
}
