import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:planlistapp/cards.dart';
import 'package:planlistapp/data_task.dart';
import 'add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late BannerAd _bannerAd;
  bool isBanner = false;

  static const AdRequest request = AdRequest();



  void createBanner() {
    _bannerAd = BannerAd(
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isBanner = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('failed ${error.message}');
        }));
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized(); //adMob ve sharedreferens için
    MobileAds.instance.initialize(); //adMOb için
    createBanner();
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeab78b) ,
        title: const Text(
          'PlanList',
          style: TextStyle(
            fontFamily: "RubikBubbles",
            fontSize: 20,
            color: Color(0xff571919),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: true,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('${Provider.of<DataTask>(context).tasks.length} PLAN',
                        style: const TextStyle(
                          fontFamily: 'Quicksand-Medium',
                          fontSize: 30,

                          color:  Color(0xff571919),

                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                      itemCount: Provider.of<DataTask>(context).tasks.length,
                      itemBuilder: (context, index) => Cards(
                            title: Provider.of<DataTask>(context)
                                .tasks[index]
                                .title,
                            isDone: Provider.of<DataTask>(context)
                                .tasks[index]
                                .isDone,
                            toggleStatus: (_) {
                              Provider.of<DataTask>(context, listen: false)
                                  .ToggleStatus(index);
                            },
                            deleteTask: (_) {
                              Provider.of<DataTask>(context, listen: false)
                                  .DeleteTask(index);
                            },
                          )),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
              child: AdWidget(ad: _bannerAd),
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              alignment: Alignment.bottomCenter,

            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.00,right: 30.00),
        child: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            backgroundColor: const Color(0xfff7e5cf),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: AdderTask())); //add card
            },
            child:const Icon(Icons.add_box,color: Color(0xff571919),size: 40,),
          ),
        ),
      ),
    );
  }
}
