// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color bulletPrimario;
  final Color bulletSecundario;
  final double bulletBig;
  final double bulletSmall;

  const Slideshow({
    super.key,
    required this.slides,
    this.puntosArriba = false,
    required this.bulletPrimario,
    required this.bulletSecundario,
    this.bulletSmall = 12,
    this.bulletBig = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideModelShow(
          bulletPrimario, bulletSecundario, bulletBig, bulletSmall),
      child: SafeArea(
        child: Center(
            child: Column(
          children: [
            if (puntosArriba) _Dots(totalSlides: slides.length),
            Expanded(
              child: _Slides(slides),
            ),
            if (!puntosArriba) _Dots(totalSlides: slides.length),
          ],
        )),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots({
    required this.totalSlides,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (index) => _Dot(index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideModelShow>(context);

    double bulletsize;
    Color color;

    if (ssModel.currentPage >= index - 0.5 &&
        ssModel.currentPage < index + 0.5) {
      bulletsize = ssModel.bulletBig;
      color = ssModel.bulletPrimario;
    } else {
      bulletsize = ssModel.bulletSmall;
      color = ssModel.bulletSecundario;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: bulletsize,
      height: bulletsize,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      Provider.of<_SlideModelShow>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList());
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}

//modelo provider
class _SlideModelShow with ChangeNotifier {
  double _currentPage = 0;
  Color _bulletPrimario = Colors.blue;
  Color _bulletSecundario = Colors.grey;
  double _bulletBig = 12;
  double _bulletSmall = 12;

  _SlideModelShow(
    this._bulletPrimario,
    this._bulletSecundario,
    this._bulletBig,
    this._bulletSmall,
  );

  double get currentPage => _currentPage;
  set currentPage(double pagina) {
    _currentPage = pagina;
    notifyListeners();
  }

  Color get bulletPrimario => _bulletPrimario;
  set bulletPrimario(Color color) {
    _bulletPrimario = color;
    notifyListeners();
  }

  Color get bulletSecundario => _bulletSecundario;
  set bulletSecundario(Color color) {
    _bulletSecundario = color;
    notifyListeners();
  }

  double get bulletBig => _bulletBig;
  set bulletBig(double bulletSize) {
    _bulletBig = bulletSize;
    notifyListeners();
  }

  double get bulletSmall => _bulletSmall;
  set bulletSmall(double bulletSize) {
    _bulletSmall = bulletSize;
    notifyListeners();
  }
}
