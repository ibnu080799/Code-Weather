import '../../utils/style.dart';
import 'package:flutter/material.dart';

class CuacaSekitarList extends StatelessWidget {
  const CuacaSekitarList({
    Key? key,
    required this.listCity,
    required this.weatherList,
  }) : super(key: key);

  final List listCity;
  final List? weatherList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listCity.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        print('DATA CUACA = $weatherList');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                  color: const Color(0xff212121),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: SizedBox(
                      child: Builder(builder: (context) {
                        if (weatherList![index].weather[0]['main'] ==
                            'Clouds') {
                          return Image.asset(
                            "assets/images/berawan.png",
                            width: 60,
                          );
                        } else if (weatherList![index].weather[0]['main'] ==
                            'Rain') {
                          return Image.asset(
                            "assets/images/hujan_siang.png",
                            width: 60,
                          );
                        } else if (weatherList![index].weather[0]['main'] ==
                            'Haze') {
                          return Image.asset(
                            "assets/images/hujan_malam.png",
                            width: 60,
                          );
                        } else {
                          return Image.asset(
                            "assets/images/petir.png",
                            width: 60,
                          );
                        }
                      }),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherList![index].name,
                                style: titleTextStyle,
                              ),
                              Text(
                                weatherList![index].weather[0]['main'],
                                style: titleTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            "${weatherList![index].main['temp']} °C",
                            style: titleTextStyle.copyWith(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        );
      },
    );
  }
}
