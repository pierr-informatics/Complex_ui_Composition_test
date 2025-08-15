import 'package:flutter/material.dart';
import 'package:complex_ui/Client111/entity/client111_user_profile.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/street_view.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/city_view.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/state_view.dart';
import 'package:complex_ui/Client111/view/widgets/address_components/zip_code_view.dart';

class ViewAddressSection extends StatelessWidget {
  final Client111UserProfile profile;

  const ViewAddressSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Address',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          StreetView(street: profile.address),
          CityView(city: profile.city),
          StateView(state: profile.state),
          ZipCodeView(zipCode: profile.zipCode),
        ],
      ),
    );
  }
}
