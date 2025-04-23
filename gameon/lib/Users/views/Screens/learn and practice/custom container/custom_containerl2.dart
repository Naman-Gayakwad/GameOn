import 'package:flutter/material.dart';

class Circulercard extends StatefulWidget {
  final String title;
  final String image;
  final List<Color> colors;
  final List<double> stops;
  final Alignment begin;
  final Alignment end;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;
  const Circulercard(
      {super.key,
      required this.title,
      required this.image,
      required this.colors,
      required this.stops,
      required this.begin,
      required this.end,
      this.margin,
      this.onTap});

  @override
  State<Circulercard> createState() => _CirculercardState();
}

class _CirculercardState extends State<Circulercard> {
  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.26,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              stops: widget.stops,
              begin: widget.begin,
              end: widget.end,
            ),
            borderRadius: BorderRadius.circular(60),
            
          ),
          child: Padding(
            padding:  EdgeInsets.only(top: ph * 0.01,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: pw * 0.18,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  widget.title,
                  maxLines: 2,
                  style:  TextStyle(fontSize: ph * 0.012, color: Colors.black, fontWeight: FontWeight.w700, ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
