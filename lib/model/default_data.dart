import 'package:flutter/material.dart';

import '../helpers/styleguide.dart';

List<Color> gradientColorOne = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a)
];

List<Color> gradientColorTwo = [Colors.purple, Colors.deepPurpleAccent];

List<Map<String, dynamic>> dataList = [
  {
    "servicename": "Hair Cut",
    "checkvalue": false,
    // "serviceitem": {
    "categoryname": "Skin Care",
    "price": "12,000 MMK",
    "starttime": "11:00 AM",
    "endtime": "12:00 PM",
    "date": "Visible",
    "action": '',
    // }
  },
  {
    "servicename": "Nail Art",
    "checkvalue": false,
    // "serviceitem": {
    "categoryname": "Skin Care",
    "price": "12,000 MMK",
    "starttime": "11:00 AM",
    "endtime": "12:00 PM",
    "date": "Visible",
    "action": '',
    // }
  },
  {
    "servicename": "Hair Washing",
    "checkvalue": false,
    // "serviceitem": {
    "categoryname": "Skin Care",
    "price": "12,000 MMK",
    "starttime": "11:00 AM",
    "endtime": "12:00 PM",
    "date": "Visible",
    "action": '',
    // }
  },
  {
    "servicename": "Hair Cut",
    "checkvalue": false,
    // "serviceitem": {
    "categoryname": "Skin Care",
    "price": "12,000 MMK",
    "starttime": "11:00 AM",
    "endtime": "12:00 PM",
    "date": "Visible",
    "action": '',
    "duration": "1 Hr",
    // },
  },
  {
    "servicename": "Nail Art",
    "checkvalue": false,
    // "serviceitem": {
    "categoryname": "Skin Care",
    "price": "12,000 MMK",
    "starttime": "11:00 AM",
    "endtime": "12:00 PM",
    "date": "Visible",
    "action": '',
    // }
  },
  {
    "servicename": "Hair Cut",
    "checkvalue": false,
    // "serviceitem": {
    "categoryname": "Skin Care",
    "price": "12,000 MMK",
    "starttime": "11:00 AM",
    "endtime": "12:00 PM",
    "date": "Visible",
    "action": '',
    // }
  },
  {
    "servicename": "Nail Art",
    "checkvalue": false,
    // "serviceitem": {
    "categoryname": "Skin Care",
    "price": "12,000 MMK",
    "starttime": "11:00 AM",
    "endtime": "12:00 PM",
    "date": "Visible",
    "action": '',
    // }
  },
];

List<Map<String, dynamic>> breakTimeList = [
  {
    "title": "Breakfast",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "enabled": "Yes",
    "checkvalue": false,
  },
  {
    "title": "Lunch",
    "starttime": "12 PM",
    "endtime": "1 PM",
    "enabled": "Yes",
    "checkvalue": false,
  },
  {
    "title": "Dinner",
    "starttime": "11 AM",
    "endtime": "12 AM",
    "enabled": "Yes",
    "checkvalue": false,
  },
  {
    "title": "Breakfast",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "enabled": "Yes",
    "checkvalue": false
  },
];

List<Map<String, dynamic>> staffList = [
  {
    "name": "John Smuit",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Junior kolar",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Miss Oller Harlay",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Harry Potter",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Anolar Home",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Archar Rolan",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "John Smuit",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Junior kolar",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Miss Oller Harlay",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Harry Potter",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Anolar Home",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Archar Rolan",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "John Smuit",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Junior kolar",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Miss Oller Harlay",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Harry Potter",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Anolar Home",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Archar Rolan",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "John Smuit",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Junior kolar 20",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Miss Oller Harlay",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Harry Potter",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Anolar Home",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Archar Rolan",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "John Smuit",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Junior kolar",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Miss Oller Harlay",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Harry Potter",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Anolar Home",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Archar Rolan",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "John Smuit",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Junior kolar",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Miss Oller Harlay",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Harry Potter",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Anolar Home",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
  {
    "name": "Archar Rolan 16",
    "email": "johnsmuit999@gmail.com",
    "phone": "09 6864 999 32",
    "position": "Manager",
    "status": "Active",
    "checkvalue": false,
  },
];

List<Map<String, dynamic>> paymentList = [
  {
    "name": "Stripe",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "Paypal",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "MPU",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "Master Card",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "Stripe",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "Paypal",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "MPU",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "Master Card",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "Paypal",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "MPU",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
  {
    "name": "Master Card",
    "availableclient": "No",
    "enabled": "No",
    "checkvalue": false
  },
];

List<Map<String, dynamic>> bookingList = [
  {
    "service": "Hair Cut",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
  {
    "service": "Nail Art",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
  {
    "service": "Hair Color Change",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
  {
    "service": "Shampoo VitE",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
  {
    "service": "Hair Cut",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
  {
    "service": "Nail Art",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
  {
    "service": "Hair Color Change",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
  {
    "service": "Shampoo VitE",
    "status": "Confirmed",
    "starttime": "12 PM",
    "endtime": "1 AM",
    "payment": "Paid",
    "bill": "12,000 MMK",
    "checkvalue": false
  },
];

List<Map<String, dynamic>> sellerList = [
  {
    "image": "assets/images/5.jpg",
    "name": "Selena Gomez",
    "price": "75,000",
    "button": "Pre",
    "color": color,
    "isSwitched": false,
  },
  {
    "image": "assets/images/robert.jpg",
    "name": "Robert",
    "price": "75,000",
    "button": "Paid",
    "color": Colors.orange,
    "isSwitched": false,
  },
  {
    "image": "assets/images/5.jpg",
    "name": "Selena Gomez",
    "price": "75,000",
    "button": "Pending",
    "color": Colors.purple[400],
    "isSwitched": false,
  },
  {
    "image": "assets/images/robert.jpg",
    "name": "Robert",
    "price": "75,000",
    "button": "Pre",
    "color": Colors.orange,
    "isSwitched": false,
  },
  {
    "image": "assets/images/5.jpg",
    "name": "Selena Gomez",
    "price": "75,000",
    "button": "Pre",
    "color": Colors.blue,
    "isSwitched": false,
  },
  {
    "image": "assets/images/5.jpg",
    "name": "Selena Gomez",
    "price": "75,000",
    "button": "Pending",
    "color": Colors.purple[400],
    "isSwitched": false,
  },
];

List<Map<String, dynamic>> lineChartBarDataList = [
  {
    "oneFirstSpot": 0.0,
    "oneSecSpot": 1.0,
    "twoFirstSpot": 2.0,
    "twoSecSpot": 2.0,
    "threeFirstSpot": 4.0,
    "threeSecSpot": 0.5,
    "fourFirstSpot": 6.0,
    "fourSecSpot": 3.5,
    "fiveFirstSpot": 8.0,
    "fiveSecSpot": 2.0,
    "sixFirstSpot": 10.5,
    "sixSecSpot": 3.0,
    "sevFirstSpot": 11.0,
    "sevSecSpot": 2.0,
    "eightFirstSpot": 12.5,
    "eightSecSpot": 1.0,
    "nineFirstSpot": 15.0,
    "nineSecSpot": 3.0,
    "text": 170.0,
    "color": [
      const Color(0xFF6600cc).withOpacity(0.2),
      const Color(0xFF6600cc).withOpacity(0.3),
      Colors.grey.withOpacity(0.1),
      const Color(0xff23b6e6).withOpacity(0.2),
      Colors.grey.withOpacity(0.1),
      const Color(0xff02d39a).withOpacity(0.2),
    ],
    "price": "180,000",
  },
  {
    "oneFirstSpot": 0.0,
    "oneSecSpot": 0.5,
    "twoFirstSpot": 3.0,
    "twoSecSpot": 2.5,
    "threeFirstSpot": 5.0,
    "threeSecSpot": 3.0,
    "fourFirstSpot": 7.0,
    "fourSecSpot": 1.5,
    "fiveFirstSpot": 9.0,
    "fiveSecSpot": 0.5,
    "sixFirstSpot": 11.5,
    "sixSecSpot": 4.0,
    "sevFirstSpot": 13.0,
    "sevSecSpot": 2.0,
    "eightFirstSpot": 14.5,
    "eightSecSpot": 3.0,
    "nineFirstSpot": 15.0,
    "nineSecSpot": 1.0,
    "color": [
      const Color(0xff23b6e6).withOpacity(0.2),
      const Color(0xff02d39a).withOpacity(0.2),
      Colors.grey.withOpacity(0.1),
      const Color(0xff23b6e6).withOpacity(0.2),
      Colors.grey.withOpacity(0.1),
      const Color(0xff02d39a).withOpacity(0.2),
    ],
    "price": "180,000",
  },
];

List<Map<String, dynamic>> spotList = [
  {
    "firstSpot": 0.0,
    "secSpot": 1.0,
  },
  {
    "firstSpot": 2.0,
    "secSpot": 2.0,
  },
  {
    "firstSpot": 4.0,
    "secSpot": 0.5,
  },
  {
    "firstSpot": 6.0,
    "secSpot": 3.5,
  },
  {
    "firstSpot": 8.0,
    "secSpot": 2.0,
  },
  {
    "firstSpot": 10.5,
    "secSpot": 3.0,
  },
  {
    "firstSpot": 11.0,
    "secSpot": 2.0,
  },
  {
    "firstSpot": 12.5,
    "secSpot": 1.0,
  },
  {
    "firstSpot": 15.0,
    "secSpot": 3.0,
  },
];

List<Map<String, dynamic>> spotListOne = [
  {
    "firstSpot": 0.0,
    "secSpot": 0.5,
  },
  {
    "firstSpot": 3.0,
    "secSpot": 2.5,
  },
  {
    "firstSpot": 5.0,
    "secSpot": 3.0,
  },
  {
    "firstSpot": 7.0,
    "secSpot": 1.5,
  },
  {
    "firstSpot": 9.0,
    "secSpot": 0.5,
  },
  {
    "firstSpot": 11.5,
    "secSpot": 4.0,
  },
  {
    "firstSpot": 13.0,
    "secSpot": 2.0,
  },
  {
    "firstSpot": 14.5,
    "secSpot": 3.0,
  },
  {
    "firstSpot": 15.0,
    "secSpot": 1.0,
  },
];
