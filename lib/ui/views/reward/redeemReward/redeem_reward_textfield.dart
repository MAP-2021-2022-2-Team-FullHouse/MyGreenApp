import 'package:flutter/material.dart';
import 'redeem_reward_screen.dart';
import 'widget/redeem_textfield.dart';


List<Widget> buildRedeemTextFields(RedeemRewardScreenState state) => [
       RedeemTextField(
        controller: state.addressController,
        hintText: "12, Jalan Rezak 1, Taman Razak 17900 Kuala Lumpur.",
        labelText: "Shipping Address:",
      ),
      const SizedBox(
        height: 5.0,
      ),
     RedeemTextField(
        controller: state.phoneController,
        hintText: "+60123456789",
        labelText: "Phone Number:",
      ),
      const SizedBox(
        height: 5.0,
      ),
      
      
      
    ];
