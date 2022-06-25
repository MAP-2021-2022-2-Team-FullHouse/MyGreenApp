import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/widget/create_dropdown.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/widget/create_textfield.dart';

List<Widget> buildCreateTextFields(CreateListingScreenfulState state) => [
      const SizedBox(height: 5.0,),
      const Text("Category: ", style: TextStyle(fontSize: 12),),
      CreateDropdownInput(
        currentValue: state.currentCategory, 
        items: state.categoryList, 
        state: state, 
        title: "Category",
        ),
      const SizedBox(height: 5.0,),
      CreateTextField(
        controller: state.titleController,
        hintText: "Name your listing",
        labelText: "Title: ",
      ),
      const SizedBox(height: 5.0,),
      const Text("Condition: ", style: TextStyle(fontSize: 12),),
      CreateDropdownInput(
        currentValue: state.currentCondition, 
        items: state.conditionList, 
        state: state, 
        title: "Condition",
        ),
      const SizedBox(height: 5.0,),
      CreateTextField(
        controller: state.priceController,
        hintText: "10.00",
        labelText: "Price: (RM)",
        keyboard:  const TextInputType.numberWithOptions(decimal: true),
        
      ),
      const SizedBox(height: 5.0,),
      CreateTextField(
        controller: state.descriptionController,
        hintText: "Describe your listing (brand, size, condition, etc)",
        labelText: "Description: ",
      ),
      const SizedBox(height: 5.0,),
      const Text("Deal Method: ", style: TextStyle(fontSize: 12),),
      CreateDropdownInput(
        currentValue: state.currentMethod, 
        items: state.methodList, 
        state: state, 
        title: "Method",
        ),
    ];
