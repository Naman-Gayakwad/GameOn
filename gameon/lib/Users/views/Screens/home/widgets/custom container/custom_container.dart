import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavCard extends StatefulWidget {
  final String title;
  final String image;
  final List<Color> colors;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;
  final EdgeInsetsGeometry? margin;

  final Function()? onTap;

  const NavCard(
      {super.key,
      required this.title,
      required this.image,
      this.onTap,
      required this.colors,
      required this.stops,
      required this.begin,
      required this.end, required this.margin});

  @override
  State<NavCard> createState() => _NavCardState();
}

class _NavCardState extends State<NavCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!();
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.275,
          height: MediaQuery.of(context).size.height * 0.155,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              stops: widget.stops,
              begin: widget.begin,
              end: widget.end,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.116,
                width: MediaQuery.of(context).size.width * 0.24,
                margin: widget.margin,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: MediaQuery.of(context).size.height * 0.0014,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
