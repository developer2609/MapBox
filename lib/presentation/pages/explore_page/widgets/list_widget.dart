import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../viewmodels/stadium_notifier.dart';



class ListPage extends ConsumerStatefulWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  @override
  Widget build(BuildContext context) {
    final stadiums = ref.watch(stadiumNotifierProvider);
    final formatter = NumberFormat('#,###', 'en_US');

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: stadiums.when(
        data: (data) {



          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final stadium = data[index];
                    final pricePerHour = stadium.pricePerHour ?? 0;
                    final formattedNumber = formatter.format(pricePerHour).replaceAll(',', ' ');
                    return Padding(
                      padding:  EdgeInsets.only(left: 25.0,right: 25,bottom: 5,top: 5),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(width: 1,color: Color(0xFFEDEDED))
                        ),
                        child: Stack(
                          children:[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                  child:CachedNetworkImage(
                                    height: 170,
                                    width: 140,
                                    fit: BoxFit.cover, imageUrl:data[index].image ?? '' ,
                                  ),
                                ),
                                SizedBox(width: 10), // Elementlar orasidagi bo'shliq
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          stadium.name ?? "",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF181725)),
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 4), // Elementlar orasidagi bo'shliq
                                        Text(
                                          stadium.address ?? "",
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFB2B2B2)),
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 4), // Elementlar orasidagi bo'shliq
                                        Text(
                                          "${formattedNumber} uzs/hour",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF2AA64C)),
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 8), // Elementlar orasidagi bo'shliq
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 5, bottom: 16),
                                                child: SizedBox(
                                                  height: 36,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Color(0xFF2AA64C),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 12), // Add horizontal padding
                                                    ),
                                                    onPressed: () {},
                                                    child: Center( // Center the text inside the button
                                                      child: Text(
                                                        "Book now!",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 16, bottom: 16.0),
                                              child: SvgPicture.asset(
                                                'assets/svg/button_svg.svg',
                                                height: 36,
                                                width: 36,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                                top: 16,
                                left: 16
                                ,child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color(0xFF00AA5B)
                              ),
                              height: 24,
                              width: 70,
                              child: Center(child: Text("Working",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)),
                            ))
                          ],
                        ),
                      ),
                    ) ;
                  },
                ),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),  // Yuklanayotgan holat
        error: (error, stackTrace) => Center(child: Text('Error: $error')),  // Xatolik holati
      ),
    );
  }
}
