
import 'package:adhikar_acehack4_o/marketplace/views/confirm_consultation.dart';
import 'package:adhikar_acehack4_o/theme/pallete_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LawyerProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String uid;
  final String email;
  final String location;
  final String ratings;
  final String caseWon;
  final String fees;
  final String profImage;
  final String experience;
  final String desccription;
  const LawyerProfileScreen(
      {super.key,
      required this.location,
      required this.ratings,
      required this.caseWon,
      required this.email,
      required this.fees,
      required this.experience,
      required this.firstName,
      required this.lastName,
      required this.uid,
      required this.profImage,
      required this.desccription});

  @override
  State<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dateTime = DateTime.now();

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => {
              setState(() {
                _timeOfDay = value!;
              })
            });
  }

  void _showDatePicker() {
    DateTime today = DateTime.now();
    DateTime lastDate = DateTime(today.year + 1);

    showDatePicker(
      context: context,
      firstDate: today,
      lastDate: lastDate,
      initialDate: today,
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Pallete.primaryColor,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Pallete.whiteColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.firstName} ${widget.lastName}",
              style: const TextStyle(color: Pallete.whiteColor),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/ic_location.png',
                  height: 15,
                  color: Pallete.whiteColor,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  widget.location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      const TextStyle(color: Pallete.whiteColor, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                const Text('4.0',
                    style: TextStyle(color: Pallete.whiteColor, fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(
                  'assets/icons/ic_star.png',
                  height: 18,
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: const BoxDecoration(color: Pallete.primaryColor),
                  child: CachedNetworkImage(
                    imageUrl: widget.profImage,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: Pallete.primaryColor)),
                    errorWidget: (context, url, error) => Image.network(
                        'https://img.freepik.com/free-psd/3d-rendered-image-businesswoman-with-gray-hair-wearing-glasses-holding-smartphone-she-looks-friendly-professional_632498-32049.jpg?t=st=1741332188~exp=1741335788~hmac=149581ab9f2c0b4f8c46f492ded19e16147e7cbba2015c07efa25a359904797e&w=740',
                        fit: BoxFit.cover),
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 20,
                    color: Pallete.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Cases won',
                                style: TextStyle(
                                    color: Pallete.whiteColor, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.caseWon,
                                style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Experience',
                                style: TextStyle(
                                    color: Pallete.whiteColor, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.experience,
                                style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Fees',
                                style: TextStyle(
                                    color: Pallete.whiteColor, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.fees,
                                style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                child: Wrap(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Criminal'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Civil'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Finance'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Tax'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Property'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Commercial'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Divorce'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text('Family'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'About ${widget.firstName} ${widget.lastName}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                child: Text(
                    maxLines: 20,
                    overflow: TextOverflow.ellipsis,
                    widget.desccription),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'Select Date and time for Meeting',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDatePicker();
                      },
                      child: Container(
                        height: 70,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Pallete.primaryColor),
                        child: Center(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Date',
                              style: TextStyle(
                                  color: Pallete.whiteColor, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',
                              style: const TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showTimePicker();
                      },
                      child: Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Pallete.primaryColor),
                        child: Center(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Time',
                              style: TextStyle(
                                  color: Pallete.whiteColor, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _timeOfDay.format(context).toString(),
                              style: const TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ConfirmConsultation(
                        uid: widget.uid,
                          date:
                              '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',
                          time: _timeOfDay.format(context).toString(),
                          amount: '750',
                         
                          firstName: widget.firstName,
                          lastName: widget.lastName,
                          profImage: widget.profImage,
                          email: widget.email);
                    }));
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(16, 32, 55, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      'Book Consultation',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
