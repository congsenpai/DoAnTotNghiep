import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user__response.dart';

import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';
import '../../bloc/search/search_state.dart';
import '../../components/cards/big/parkingLot_info_big_card.dart';
import '../../components/pagination_button.dart';
import '../../constants.dart';

class SearchScreen extends StatefulWidget {
  final UserResponse user;
  const SearchScreen({super.key,required this.user});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<ParkingLotResponse> lots = [];
  int page=1;
  int pageAmount =1;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(SearchScreenInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // Chiều cao mong muốn
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Search', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: defaultPadding / 2),
              SearchForm(page: 1, token: '',),
            ],
          ),
        ),
        )
      ),
      body: BlocConsumer<SearchBloc,SearchState>
        (builder:  (context,state){
          if(state is SearchScreenLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is SearchScreenLoaded){
            lots = state.lotOnPage.lots;
            page = state.lotOnPage.page;
            pageAmount = state.lotOnPage.pageAmount;
            searchText = state.searchText;
            return SafeArea(

              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ListView(
                    children: [
                      const SizedBox(height: defaultPadding),
                      Text("Search Results" ,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: defaultPadding),
                      ParkingLotList(lots: lots, user: widget.user),
                      const SizedBox(height: defaultPadding),

                      PaginationButtons(page: page, pageTotal: pageAmount, onPageChanged: (newPage) {
                        setState(() {
                          page = newPage;
                          context.read<SearchBloc>().add(SearchScreenSearchAndChosenPageEvent(searchText,page)) ;// Gọi hàm search
                        });
                        // Gọi API hoặc cập nhật dữ liệu cho trang mới
                      },)// Không cần SingleChildScrollView nữa
                    ],
                  )
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);

      }, listener: (context,state){
          if(state is SearchScreenError){
            return AppDialog.showErrorEvent(context, state.mess);
          }
      })
    );
  }
}

class SearchForm extends StatefulWidget {
  final int page;
  final String token;
  const SearchForm({super.key, required this.page, required this.token});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        onFieldSubmitted: (value) {
          if (_formKey.currentState!.validate()) {
            context.read<SearchBloc>().add(SearchScreenSearchAndChosenPageEvent(_controller.text,widget.page)) ;// Gọi hàm search
          }
        },
        validator: requiredValidator.call,
        style: Theme.of(context).textTheme.labelLarge,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Search parking...",
          contentPadding: kTextFieldPadding,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              colorFilter: const ColorFilter.mode(
                bodyTextColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

