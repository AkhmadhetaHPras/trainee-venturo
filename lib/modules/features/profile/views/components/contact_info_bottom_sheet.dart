import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactInfoBottomSheet extends StatefulWidget {
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? pin;
  final String title;

  const ContactInfoBottomSheet({
    Key? key,
    this.name,
    this.phoneNumber,
    this.email,
    this.pin,
    required this.title,
  }) : super(key: key);

  @override
  State<ContactInfoBottomSheet> createState() => _ContactInfoBottomSheetState();
}

class _ContactInfoBottomSheetState extends State<ContactInfoBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;
  late final TextEditingController _pinController;
  late final String _title;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.name);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _emailController = TextEditingController(text: widget.email);
    _pinController = TextEditingController(text: widget.pin);
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Wrap(
        children: [
          16.verticalSpacingRadius,
          Text(_title.tr, style: Get.textTheme.bodyMedium),
          13.verticalSpacingRadius,
          Form(
            key: _formKey,
            child: Column(
              children: [
                if (widget.name != null)
                  ..._buildTextField(
                    controller: _nameController,
                    label: 'Name'.tr,
                    maxLength: 100,
                    validator: (value) =>
                        value?.isEmpty ?? false ? 'Name is required'.tr : null,
                  ),
                if (widget.phoneNumber != null)
                  ..._buildTextField(
                    controller: _phoneNumberController,
                    label: 'Phone Number'.tr,
                    maxLength: 15,
                    validator: (value) =>
                        null, // Add phone number validation if needed
                  ),
                if (widget.email != null)
                  ..._buildTextField(
                    controller: _emailController,
                    label: 'Email'.tr,
                    maxLength: 100,
                    validator: (value) =>
                        null, // Add email validation if needed
                  ),
                if (widget.pin != null)
                  ..._buildTextField(
                    controller: _pinController,
                    label: 'PIN'.tr,
                    maxLength: 6,
                    validator: (value) => null, // Add PIN validation if needed
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform save action here
                      if (widget.email != null) {
                        Get.back(result: _emailController.text);
                      } else if (widget.name != null) {
                        Get.back(result: _nameController.text);
                      } else if (widget.phoneNumber != null) {
                        Get.back(result: _phoneNumberController.text);
                      } else {
                        Get.back(result: _pinController.text);
                      }
                    }
                  },
                  radius: 20.r,
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTextField({
    required TextEditingController controller,
    required String label,
    required int maxLength,
    required String? Function(String?) validator,
  }) {
    return [
      TextFormField(
        controller: controller,
        keyboardType: label == "Phone Number" ? TextInputType.number : null,
        style: Get.textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: Get.textTheme.bodySmall,
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.w),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.w),
          ),
        ),
        maxLength: maxLength,
        validator: validator,
      ),
      const SizedBox(height: 10),
    ];
  }
}
