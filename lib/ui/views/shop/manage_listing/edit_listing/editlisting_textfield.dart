import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/widget/edit_dropdown.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/widget/edit_textfield.dart';

List<Widget> buildEditTextFields(EditListingScreenfulState state, Listing listing) => [
      const SizedBox(height: 5.0,),
      const Text("Category: ", style: TextStyle(fontSize: 12),),
      EditDropdownInput(
        currentValue: state.currentCategory=listing.category, 
        items: state.categoryList, 
        state: state, 
        title: "Category",
        ),
      const SizedBox(height: 5.0,),
      EditTextField(
        controller: state.titleController..text=listing.title,
        hintText: "Name your listing",
        labelText: "Title: ",
      ),
      const SizedBox(height: 5.0,),
      const Text("Condition: ", style: TextStyle(fontSize: 12),),
      EditDropdownInput(
        currentValue: state.currentCondition=listing.condition, 
        items: state.conditionList, 
        state: state, 
        title: "Condition",
        ),
      const SizedBox(height: 5.0,),
      EditTextField(
        controller: state.priceController..text=listing.price,
        hintText: "10.00",
        labelText: "Price: (RM)",
        keyboard:  const TextInputType.numberWithOptions(decimal: true),
        
      ),
      const SizedBox(height: 5.0,),
      EditTextField(
        controller: state.descriptionController..text=listing.description,
        hintText: "Describe your listing (brand, size, condition, etc)",
        labelText: "Description: ",
      ),
      const SizedBox(height: 5.0,),
      const Text("Deal Method: ", style: TextStyle(fontSize: 12),),
      EditDropdownInput(
        currentValue: state.currentMethod=listing.method, 
        items: state.methodList, 
        state: state, 
        title: "Method",
        ),
    ];
