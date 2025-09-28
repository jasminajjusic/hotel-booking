import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:country_picker/country_picker.dart';

class CountryPickerBottomSheet extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selectedCountry = useState<Country?>(null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: 12,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 24, color: Colors.black),
              ),
              const Spacer(),
              const Text(
                'Select your country',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF165244),
                  fontFamily: 'SFPro',
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),

        Container(height: 1, color: Colors.grey[300], width: double.infinity),

        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        selectedCountry.value = country;
                      },
                      countryListTheme: CountryListThemeData(
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'SFPro',
                        ),
                        bottomSheetHeight: 400,
                      ),
                    );
                  },
                  child: Text(
                    selectedCountry.value?.name ?? 'Select your country',
                    style: TextStyle(
                      color:
                          selectedCountry.value == null
                              ? Colors.grey
                              : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF165244),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context, selectedCountry.value?.name);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SFPro',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
