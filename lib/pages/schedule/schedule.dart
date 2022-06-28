import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/custom_dialog.dart';
import 'package:my_ride/widget/text_form_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/session_manager.dart';
import '../../models/global_model.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<String> schedulePlans = ["Instant", "Weekly", "Bi-weekly", "One month"];

  String defaultPlan = "Weekly";
  TextEditingController? pickupController =
      TextEditingController(text: 'Enter pickup location');
  TextEditingController? dropController =
      TextEditingController(text: 'Enter Destination location');
  CalendarController _calendarController = CalendarController();
  bool? isCalendar = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
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
                          height: 1.h,
                        ),
                        Text(
                          'Hi there,',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Book your ride',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 18.4.sp,
                ),
                onPressed: () {
                  Routers.pop(context);
                }),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () => showCustomDialog(context, items: schedulePlans,
                        onTap: (value) {
                      setState(() {
                        isCalendar = !isCalendar!;
                      });
                    }),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 150,
                        height: 5.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Schedule plan',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15.4.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 22.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Visibility(
                      visible: isCalendar!,
                      child: TableCalendar(
                        calendarController: _calendarController,
                      )),
                  SizedBox(
                    height: 3.h,
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
                        onError: (err) {
                          print(err);
                        },
                      );

                      if (place != null) {
                        setState(() {
                          pickUpLocationAdd = place.description;
                          pickupController =
                              TextEditingController(text: pickUpLocationAdd);
                        });
                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        pickUpLat = geometry.location.lat.toString();
                        pickUpLong = geometry.location.lng.toString();
                      }
                    },
                    readOnly: true,
                    controller: pickupController,
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(top: 2.9.w, left: 3.5.w),
                      child: FaIcon(
                        FontAwesomeIcons.person,
                        size: 20.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
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
                        onError: (err) {
                          print(err);
                        },
                      );

                      if (place != null) {
                        setState(() {
                          dropLocationAdd = place.description;
                          dropController =
                              TextEditingController(text: dropLocationAdd);
                        });
                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        dropLat = geometry.location.lat.toString();
                        dropLong = geometry.location.lng.toString();
                      }
                    },
                    readOnly: true,
                    controller: dropController,
                    prefixWidget: Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Add place'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'RECENT PLACES',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                        fontSize: 17.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: const [
                          Positioned(
                            child: CircleAvatar(
                              backgroundColor: Colors.black12,
                              radius: 15,
                            ),
                          ),
                          Positioned(
                              left: 2.9,
                              top: 1.5,
                              child: Icon(
                                Icons.house_outlined,
                                color: Colors.black26,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'No 33, Boulevard Street',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: const [
                          Positioned(
                            child: CircleAvatar(
                              backgroundColor: Colors.black12,
                              radius: 15,
                            ),
                          ),
                          Positioned(
                              left: 2.9,
                              top: 1.5,
                              child: Icon(
                                Icons.house_outlined,
                                color: Colors.black26,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'No 33, Boulevard Street',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'View Schedule',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 180,
                        height: 5.h,
                        decoration: const BoxDecoration(
                          color: Color(0XFF000B49),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
