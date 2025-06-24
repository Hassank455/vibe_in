import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/features/order_details/ui/widgets/have_an_issue_order_details_widget.dart';
import 'package:vibe_in/features/order_details/ui/widgets/header_order_details_widget.dart';
import 'package:vibe_in/features/order_details/ui/widgets/payment_method_order_details_widget.dart';
import 'package:vibe_in/features/order_details/ui/widgets/payment_summary_order_details_widget.dart';
import 'package:vibe_in/features/order_details/ui/widgets/products_order_details_widget/products_order_details_widget.dart';
import 'package:vibe_in/features/order_details/ui/widgets/shipping_address_order_details_widget.dart';
import 'package:vibe_in/features/order_details/ui/widgets/stepper_order_details_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderOrderDetailsWidget(),
            verticalSpaceRemoved(AppSize.s20),
            StepperOrderDetailsWidget(),
            verticalSpaceRemoved(AppSize.s25),
            ProductsOrderDetailsWidget(),
            verticalSpaceRemoved(AppSize.s25),
            ShippingAddressOrderDetailsWidget(),
            verticalSpaceRemoved(AppSize.s25),
            PaymentSummaryOrderDetailsWidget(),
            verticalSpaceRemoved(AppSize.s25),
            PaymentMethodOrderDetailsWidget(),
            verticalSpaceRemoved(AppSize.s25),
            HaveAnIssueOrderDetailsWidget(),
            verticalSpaceRemoved(AppSize.s25),
          ],
        ).marginSymmetric(horizontal: AppSize.s16.w),
      ),
    );
  }
}
