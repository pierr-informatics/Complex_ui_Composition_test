import 'package:flutter/material.dart';
import 'package:complex_ui/Client111/entity/client111_user_profile.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/street_edit.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/city_edit.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/state_edit.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/zip_code_edit.dart';

class EditAddressSection extends StatefulWidget {
  final Client111UserProfile profile;
  final GlobalKey<FormState> formKey;

  const EditAddressSection({
    super.key,
    required this.profile,
    required this.formKey,
  });

  @override
  State<EditAddressSection> createState() => _EditAddressSectionState();
}

class _EditAddressSectionState extends State<EditAddressSection> {
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.profile.address);
    _cityController = TextEditingController(text: widget.profile.city);
    _stateController = TextEditingController(text: widget.profile.state);
    _zipController = TextEditingController(text: widget.profile.zipCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        StreetEdit(
          controller: _addressController,
          onChanged: (value) => widget.profile.address = value,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CityEdit(
                controller: _cityController,
                onChanged: (value) => widget.profile.city = value,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StateEdit(
                controller: _stateController,
                onChanged: (value) => widget.profile.state = value,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ZipCodeEdit(
                controller: _zipController,
                onChanged: (value) => widget.profile.zipCode = value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
