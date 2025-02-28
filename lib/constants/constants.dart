
import '../widgets/grid_item.dart';
import 'package:flutter/material.dart';

final List<GridItem> rechargeItems = [
  GridItem(title: "Mobile Recharge", icon: Icons.phone_android),
  GridItem(title: "DTH Recharge", icon: Icons.tv),
  GridItem(title: "Broadband", icon: Icons.router),
  GridItem(title: "FASTag", icon: Icons.directions_car),
];

final List<GridItem> utilityBillItems = [
  GridItem(title: "Electricity", icon: Icons.electrical_services),
  GridItem(title: "Water", icon: Icons.water),
  GridItem(title: "Gas", icon: Icons.local_gas_station),
  GridItem(title: "Landline", icon: Icons.phone),
];

final List<GridItem> financeTaxItems = [
  GridItem(title: "Insurance", icon: Icons.security),
  GridItem(title: "Loan", icon: Icons.account_balance),
  GridItem(title: "Credit Cards", icon: Icons.credit_card),
  GridItem(title: "Tax", icon: Icons.receipt),
];

final List<GridItem> moreItems = [
  GridItem(title: "Subscription", icon: Icons.subscriptions),
  GridItem(title: "Housing", icon: Icons.home),
  GridItem(title: "Rent", icon: Icons.apartment),
];
