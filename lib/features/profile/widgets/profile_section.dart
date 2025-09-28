import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelbooking/features/profile/widgets/info_tile.dart';
import 'package:hotelbooking/features/profile/widgets/bottom_sheet_helper.dart';
import 'package:hotelbooking/features/profile/widgets/name_bottom_sheet.dart';
import 'package:hotelbooking/features/profile/widgets/birth_date_bottom_sheet.dart';
import 'package:hotelbooking/features/profile/widgets/country_bottom_sheet.dart';
import 'package:hotelbooking/features/profile/widgets/phone_number_bottom_sheet.dart';
import 'package:hotelbooking/features/profile/cubit/profile_cubit.dart';
import 'package:hotelbooking/features/profile/data/models/profile_model.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, Profile>(
      builder: (context, profile) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Information',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF165244),
                fontFamily: 'SFPro',
              ),
            ),
            const SizedBox(height: 16),

            InfoTile(
              title: 'Legal Name',
              subtitle:
                  profile.name.isNotEmpty
                      ? profile.name
                      : 'Add your legal name',
              onTap: () async {
                final name = await BottomSheetHelper.show<String>(
                  context,
                  NameBottomSheet(),
                );
                if (name != null && name.isNotEmpty) {
                  context.read<ProfileCubit>().upsertName(name);
                  await context.read<ProfileCubit>().saveProfile();
                }
              },
            ),

            InfoTile(
              title: 'Date of Birth',
              subtitle:
                  profile.dateOfBirth != null
                      ? '${profile.dateOfBirth!.day.toString().padLeft(2, '0')}.${profile.dateOfBirth!.month.toString().padLeft(2, '0')}.${profile.dateOfBirth!.year}'
                      : 'Add your date of birth',
              onTap: () async {
                final date = await BottomSheetHelper.show<DateTime>(
                  context,
                  DateOfBirthBottomSheet(),
                );
                if (date != null) {
                  context.read<ProfileCubit>().upsertDateOfBirth(date);
                  await context.read<ProfileCubit>().saveProfile();
                }
              },
            ),

            InfoTile(
              title: 'Country',
              subtitle:
                  profile.country.isNotEmpty
                      ? profile.country
                      : 'Select your country',
              onTap: () async {
                final country = await BottomSheetHelper.show<String>(
                  context,
                  CountryPickerBottomSheet(),
                );
                if (country != null && country.isNotEmpty) {
                  context.read<ProfileCubit>().upsertCountry(country);
                  await context.read<ProfileCubit>().saveProfile();
                }
              },
            ),

            InfoTile(
              title: 'Phone Number',
              subtitle:
                  profile.phoneNumber.isNotEmpty
                      ? profile.phoneNumber
                      : 'Add your phone number',
              onTap: () async {
                final phone = await BottomSheetHelper.show<String>(
                  context,
                  PhoneNumberBottomSheet(),
                );
                if (phone != null && phone.isNotEmpty) {
                  context.read<ProfileCubit>().upsertPhoneNumber(phone);
                  await context.read<ProfileCubit>().saveProfile();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
