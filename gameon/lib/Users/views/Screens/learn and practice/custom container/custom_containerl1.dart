import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navcard2 extends StatefulWidget {
  final String title;
  final String image;
  final List<Color> colors;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const Navcard2({
    super.key,
    required this.title,
    required this.image,
    required this.colors,
    required this.stops,
    required this.begin,
    required this.end,
    this.margin,
    this.onTap,
  });

  @override
  State<Navcard2> createState() => _Navcard2State();
}

class _Navcard2State extends State<Navcard2> {
  
  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        widget.onTap!();
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.345,
          height: MediaQuery.of(context).size.height * 0.215,
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
          child: Padding(
            padding:  EdgeInsets.only(
              top: ph * 0.02,
              bottom: ph * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.3,
                  margin: widget.margin,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Spacer(),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: ph * 0.02,
                    fontWeight: FontWeight.w500,
                    height: MediaQuery.of(context).size.height * 0.0014,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
