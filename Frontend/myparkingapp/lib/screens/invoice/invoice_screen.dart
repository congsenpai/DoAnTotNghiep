import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myparkingapp/bloc/invoice/invoice_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/components/pagination_button.dart';
import 'package:myparkingapp/data/response/user__response.dart';
import '../../constants.dart';
import '../../data/response/invoice_response.dart';
import 'components/invoice_list.dart';

class InvoiceScreen extends StatefulWidget {
  final UserResponse user;
  const InvoiceScreen({super.key, required this.user});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(InvoiceInitialEvent(widget.user, "", 1));
  }
  

  List<InvoiceResponse> invoices = [];
  int page = 1;
  int pageAmount = 1;
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceBloc,InvoiceState>
      (builder: (context,state) {
        if(state is InvoiceLoadingState){
          return Center(
              child: CircularProgressIndicator(),
          );
        }
        else if(state is InvoiceLoadedState){
          invoices = state.invoices;
          page = state.page;
          pageAmount = state.pageAmount;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Your Orders"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    SearchForm(page: page,user: widget.user),
                    const SizedBox(height: defaultPadding),
                    // List of cart items
                    ...List.generate(
                      invoices.length,
                          (index) => Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        child: InvoiceList(invoice: invoices[index],)
                        ),
                      ),
                    PaginationButtons(page: page, pageAmount: pageAmount, onPageChanged: (newPage) {
                        setState(() {
                          page = newPage;
                          context.read<InvoiceBloc>().add(InvoiceInitialEvent(widget.user, searchText, 1));;// Gọi hàm search
                        });
                        // Gọi API hoặc cập nhật dữ liệu cho trang mới
                      },)
                  ],
                ),
              ),
            ),
          );

        }
        return Center(
          child: CircularProgressIndicator(),
        );
    }, listener: (context,state){
        if(state is InvoiceErrorState){
          AppDialog.showErrorEvent(context, state.mess);
        }
    });
  }
}

class SearchForm extends StatefulWidget {
  final UserResponse user;
  final int page;
  const SearchForm({super.key, required this.user, required this.page});

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
            context.read<InvoiceBloc>().add(InvoiceInitialEvent(widget.user, _controller.text, widget.page)) ;// Gọi hàm search
          }
        },
        validator: requiredValidator.call,
        style: Theme.of(context).textTheme.labelLarge,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Search invoice...",
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

