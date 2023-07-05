import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/dashboard_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => DashboardProvider(),
        child: Consumer<DashboardProvider>(
          builder: (context,provider,_) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Visibility(
                visible: provider.isLoaded,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0)),
                          color: Colors.blue.shade400,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0,bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white60,
                                      size:
                                      MediaQuery.textScaleFactorOf(context) * 28,
                                    ),
                                  ),
                                  Text(
                                    provider.city,
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontSize:
                                        MediaQuery.textScaleFactorOf(context) *
                                            20),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                               Text(
                                '${provider.temp}°C',
                                style: const TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white54),
                              ),

                              Column(
                                children: [
                                  Text(
                                    DateFormat('EEEE').format(DateTime.now()),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white54),
                                  ),
                                  Text(
                                    DateFormat('dd/mm/yyyy').format(DateTime.now()),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Row(children: [Padding(
                      padding: EdgeInsets.only(left: 15,top: 20),
                      child: Text("7 Days",style: TextStyle(color: Colors.grey),),
                    ),],),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (context, index){
                            final currentDate = DateTime.now().add(Duration(days: index));
                            final formattedDate = DateFormat('dd MMM').format(currentDate);
                        return Container(
                          width: 60,
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                              const Image(
                                height:25,
                                width: 32,
                                image: AssetImage('assets/Image/weather.jpeg'),
                                fit: BoxFit.cover,
                              ),
                              const Text("20°C",style:TextStyle(color: Colors.white),)
                            ],
                          ),
                        );
                      }),
                    )

                  ],
                ),
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
