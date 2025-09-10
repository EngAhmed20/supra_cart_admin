import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra_cart_admin/features/orders/cubit/orders_cubit.dart';
import 'package:supra_cart_admin/features/orders/views/widget/orders_page_view.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/loadibg_ink_drop.dart';
import 'order_type_title_list.dart';
class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit,OrdersState>(
      builder: (BuildContext context, OrdersState state) {
        if(state is GetOrdersLoading){
          return Loading_body(context);
        }
        else if(state is GetOrdersFailure){
          return Center(child: Text(state.message,style: textStyle.Bold16));
        }
        var cubit=context.watch<OrdersCubit>();
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: OrdersTypeList(currentPageIndex: cubit.currentPageIndex,onOrderTypeSelected: (val){
                cubit.onTapOnOrderType(val);
              },),
            ),
            SliverFillRemaining(
              child: OrdersPageView(pageController: cubit.pageController,cubit: cubit,),
            ),

          ],
        );
      },
      listener: (BuildContext context, OrdersState state) {  },

    );
  }
}
