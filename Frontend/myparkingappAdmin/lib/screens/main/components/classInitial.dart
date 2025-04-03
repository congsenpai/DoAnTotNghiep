// ignore_for_file: file_names





import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';

UserResponse selectedUserInitial = UserResponse(
    username: "",
    password: "",
    phoneNumber: "",
    homeAddress: "",
    companyAddress: "",
    lastName: "",
    firstName: "Hà",
    avatar: "",
    email: "", userId: '',
    status: true, roles: [],
  );
  UserResponse selectedLotOwnerInitial = UserResponse(
    phoneNumber: '',
    homeAddress: '',
    companyAddress: '',
    lastName: '',
    firstName: '',
    avatar: '',
    email: '',
    status: true, username: '', roles: ['USER'], userId: '', password: '',
  );
  WalletResponse selectedWalletInitial = WalletResponse(
    name: "",
    balance: 1328,
    svgSrc: "",
    walletId: '',
    userId: '',
    status: true, currency: '',
  );
  TransactionResponse selectedTransactionInitial = TransactionResponse(
    icon: "",
    bankName: "",
    date: DateTime.now(),

    typeMoney:"",

    transactionId: '', walletId: '', description: '', amount: 0, type: TransactionType.PAYMENT
  );
  ParkingLotResponse selectedParkingLotInitial =
  ParkingLotResponse(
      userId: "1",
      status: true,
      description: "",
      parkingLotId: '',
      parkingLotName: '',
      address: '',
      latitude: 0,
      longitude: 0,
      totalSlot: 0,
      rate: 0,
  );
  ParkingSlotResponse selectedParkingSlotInitial =
      ParkingSlotResponse(
          slotId: '',
          vehicleType: '',
          slotStatus: "",
          pricePerHour: 0,
          pricePerMonth: 0,
          parkingLotId: "", slotName: '');