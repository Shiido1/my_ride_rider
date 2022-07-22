import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/colors.dart';
import '../../constants/session_manager.dart';
import '../../controllers/home_controller.dart';
import '../../models/provider.dart';
import '../../utils/router.dart';
import '../../widget/text_form_field.dart';
import '../../widget/text_widget.dart';

class HomeSearchDestination extends StatefulWidget {
  const HomeSearchDestination({Key? key}) : super(key: key);

  @override
  _HomeSearchDestinationState createState() => _HomeSearchDestinationState();
}

class _HomeSearchDestinationState extends StateMVC<HomeSearchDestination> {
  _HomeSearchDestinationState() : super(HomeController()) {
    con = controller as HomeController;
  }

  late HomeController con;

  TextEditingController destinationController =
      TextEditingController(text: 'Enter destination location');

  @override
  Widget build(BuildContext context) {
    Provider.of<GoogleApiProvider>(context, listen: false).getLocationHistory();
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
              height: 350,
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text:'Nearest ride is',
                              fontSize: 16.sp,
                              color: Colors.white,
                          ),
                          TextView(
                            text:'minutes away',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                          ),
                        ],
                      ),
                      SessionManager.instance.usersData["profile_picture"] ==
                                  null ||
                              SessionManager
                                      .instance.usersData["profile_picture"] ==
                                  ''
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: AppColors.grey1,
                                size: 23.sp,
                              ),
                              radius: 26,
                            )
                          : CircleAvatar(
                              radius: 28,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const CircularProgressIndicator(),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextView(
                    text: "Your Pickup Location",
                      fontSize: 18.sp,
                      color: Colors.white,

                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextView(
                    text:"$pickUpLocationAdd",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,

                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Routers.replaceAllWithName(context, '/home'),
                    child: Row(
                      children: [
                        Text(
                          "Change Location",
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20.sp,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.greyWhite,
              padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    EditTextForm(
                      onTapped: () async {
                        var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'ng')],
                          //google_map_webservice package
                          onError: (err) {},
                        );

                        if (place != null) {
                          setState(() {
                            dropLocationAdd = place.description;
                            destinationController =
                                TextEditingController(text: dropLocationAdd);
                          });
                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(
                            apiKey: googleApikey,
                            apiHeaders:
                                await const GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeId = place.placeId ?? "0";
                          final detail =
                              await plist.getDetailsByPlaceId(placeId);
                          final geometry = detail.result.geometry!;
                          dropLat = geometry.location.lat.toString();
                          dropLong = geometry.location.lng.toString();
                        }
                      },
                      readOnly: true,
                      controller: destinationController,
                      suffixWidget: InkWell(
                          onTap: () {
                            Routers.pushNamed(context, '/select_ride');
                          },
                          child: const Icon(Icons.search)),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                TextView(
                  text:'No History',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    SizedBox(
                        height: 32.h,
                        child: Consumer<GoogleApiProvider>(
                            builder: (_, provider, __) {
                              if (provider.responses == null) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ));
                              }
                              if (provider.responses!.isEmpty) {
                                return TextView(
                                  text:'No History',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                );
                              }
                              return ListView.builder(
                                itemCount: provider.responses!["data"].length,
                                itemBuilder: (context, index) {
                                  return addedHistory(text:provider
                                      .responses!["data"][index]["drop_address"],lat:provider
                                      .responses!["data"][index]["drop_lat"].toString(),long:provider
                                      .responses!["data"][index]["drop_lng"].toString());
                                },
                              );
                            })),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.black),
              bottom: BorderSide(width: 2.0, color: Colors.white),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.location_on_rounded,
                color: Colors.red,
              ),
              Text(
                "View on Map",
                style: TextStyle(color: Colors.black, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }

      addedHistory({String? text,String? long,String? lat}) => InkWell(
        onTap: () {
          setState(() {
            dropLocationAdd = text!;
            destinationController.text = text;
            dropLat = lat;
            dropLong = long;
          });
        },
        child: Card(
          color: Colors.blueGrey[100],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.white,
                  ),
                  radius: 15,
                ),
                SizedBox(width: 3.5.w),
                Expanded(
                  child: TextView(
                    text: text ?? "",
                    fontSize: 16.sp,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
