// import 'package:bank_loan/core/util/network/service_locator.dart';
// import 'package:bank_loan/features/clients_page/data/repo/clients_repo_impl.dart';
// import 'package:bank_loan/features/clients_page/presentation/manger/clients_cubit.dart';
// import 'package:bank_loan/features/clients_page/presentation/view/add_client_loan_screen.dart';
// import 'package:bank_loan/features/clients_page/presentation/view/clients_page.dart';
// import 'package:bank_loan/features/home_page/presentation/view/home_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../features/clients_page/presentation/view/clients_loan_page.dart';
// import '../../features/loan_page/presentation/manger/loan_cubit.dart';
//
// abstract class AppRouter {
//   static const kClientsPage = 'clientsPage';
//   static const kClientsLoan = 'clientsLoan';
//   static const kAddClientsLoan = 'addClientsLoan';
//   static final router = GoRouter(routes: [
//     GoRoute(
//         path: '/',
//         builder: (context, state) => BlocProvider(
//               create: (context) => LoanCubit(),
//               child: const Directionality(
//                   textDirection: TextDirection.rtl, child: HomePage()),
//             )),
//     GoRoute(
//         path: '/$kClientsPage',
//         builder: (context, state) => BlocProvider(
//               create: (context) => ClientsCubit(getIt.get<ClientsRepoImpl>()),
//               child: ClientsScreen(),
//             )),
//     GoRoute(
//       path: '/$kClientsLoan/:clientName/:uId',
//       builder: (context, state) {
//         final String clientName = state.pathParameters['clientName']!;
//         final String uId = state.pathParameters['uId']!;
//         return BlocProvider(
//           create: (context) => ClientsCubit(getIt.get<ClientsRepoImpl>()),
//           child: Directionality(
//             textDirection: TextDirection.rtl,
//             child: ClientLoanPage(
//               clientName: clientName,
//               uId: num.parse(uId),
//             ),
//           ),
//         );
//       },
//     ),
//     GoRoute(
//       path: '/$kAddClientsLoan/:id',
//       builder: (context, state) {
//         final String id = state.pathParameters['id']!;
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (context) => ClientsCubit(getIt.get<ClientsRepoImpl>()),
//             ),
//             BlocProvider(
//               create: (context) => LoanCubit(),
//             ),
//           ],
//           child: Directionality(
//             textDirection: TextDirection.rtl,
//             child: AddClientLoanScreen(
//               id: num.parse(id),
//             ),
//           ),
//         );
//       },
//     ),
//   ]);
// }
