import 'package:flutter/material.dart';

var scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

String baseUrl = "http://192.168.48.156:8000";

List<String> diseasesPreventingBloodDonation = [
  "Healthy",
  "HIV/AIDS",
  "Hepatitis B or C",
  "Malaria",
  "Creutzfeldt-Jakob Disease (CJD)",
  "Syphilis",
  "Zika virus infection",
  "Ebola virus disease",
  "Babesiosis",
  "Chagas disease",
  "Variant Creutzfeldt-Jakob Disease (vCJD)",
  "Active tuberculosis",
  "Sickle cell disease",
  "Hemochromatosis",
  "Certain types of cancer",
  "Autoimmune disorders",
  "Certain heart conditions",
  "Blood clotting disorders",
  "Severe anemia",
  "Recent organ transplantation or tissue graft",
  "Pregnancy or recent childbirth",
  "Recent tattoo or body piercing",
  "Intravenous drug use",
  "Recent exposure to certain infectious diseases",
  "Recent use of certain medications",
];

List<String> bloodType = [
  "N/A",
  "A+",
  "A-",
  "O+",
  "O-",
  "B+",
  "B-",
  "AB+",
  "AB-"
];
List<Map<String, String>> doctors = [
  {"assets/images/doctor1.jpg": "Roy Collins"},
  {"assets/images/doctor2.jpg": "Alexa Gagi"},
  {"assets/images/doctor3.jpg": "Billy Kim"},
];
List<Map<String, String>> events = [
  {"assets/images/blood_event_1.jpg": "Woman International Day Blood Donation"},
  {"assets/images/blood_event_2.jpg": "August Blood Donation Regular Event"},
  {"assets/images/blood_event_3.jpg": "Blood Donation for Independence Day"}
];
List flipStatus = List.filled(6, true);

Map<String, String> beforeDonation = {
  "Eat a healthy meal":
      " Make sure to eat a nutritious meal before donating blood. Avoid fatty foods and stick to foods that are high in iron.",
  "Drink plenty of water":
      "Drinking water before donating blood helps to keep you hydrated and makes it easier for the phlebotomist to find your veins.",
  "Get a good night's sleep":
      "Make sure you get enough sleep the night before you donate blood.",
  "Avoid alcohol and caffeine":
      "Avoid alcohol and caffeine for at least 24 hours before donating blood.",
  "Wear comfortable clothing":
      "Wear comfortable clothing that allows easy access to your arm for the phlebotomist.",
  "Bring identification":
      "Bring a valid ID with you when you go to donate blood."
};
Map<String, dynamic> afterDonation = {
  "Rest":
      "Take it easy for the rest of the day and avoid any strenuous activities.",
  "Hydrate":
      "Drink plenty of fluids, especially water, to help your body replace the fluids lost during donation.",
  "Eat a healthy meal":
      "Eat a nutritious meal that includes iron-rich foods like leafy greens, red meat, and beans.",
  "Avoid alcohol and smoking":
      "Refrain from drinking alcohol or smoking for at least 24 hours after donation.",
  "Monitor for side effects":
      "Watch out for any side effects such as dizziness, lightheadedness, or nausea. If you experience any of these symptoms, lie down and elevate your feet until they pass.",
  "Follow post-donation instructions":
      "Follow any instructions given by the blood donation center regarding post-donation care."
};
Map<String, dynamic> advantagesofDonation = {
  "Saves lives":
      "Blood donation helps save lives by providing a steady supply of blood to those in need, especially during emergencies and surgeries.",
  "Reduces the risk of heart disease":
      "Regular blood donation can help reduce the risk of heart disease by lowering the levels of iron in the blood, which can reduce the risk of heart attacks and strokes.",
  "Improves overall health":
      "Donating blood can help improve overall health by stimulating the production of new blood cells, which can help boost immunity and improve circulation.",
  "Helps treat certain medical conditions":
      "Blood donation can be used to treat certain medical conditions such as hemophilia, sickle cell anemia, and cancer.",
  "Provides a free health check-up":
      "Before donating blood, donors undergo a thorough health check-up that includes testing for various diseases such as HIV, hepatitis B and C, syphilis, and malaria.",
  "Promotes community involvement":
      "Blood donation is a great way to get involved in your community and make a positive impact on people's lives."
};
