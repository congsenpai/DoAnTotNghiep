// ignore_for_file: file_names



import 'package:myparkingappadmin/dto/response/parkingSlot.dart';
import '../../../dto/response/wallet.dart';
import '../../../dto/response/parkingLot.dart';
import '../../../dto/response/transaction.dart';
import '../../../dto/response/user.dart';

User selectedUserInitial = User(
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
  User selectedLotOwnerInitial = User(
    phoneNumber: '',
    homeAddress: '',
    companyAddress: '',
    lastName: '',
    firstName: '',
    avatar: '',
    email: '',
    status: true, username: '', roles: ['USER'], userId: '', password: '',
  );
  Wallet selectedWalletInitial = Wallet(
    name: "",
    balance: 1328,
    svgSrc: "",
    walletId: '',
    userId: '',
    status: true, currency: '',
  );
  Transaction selectedTransactionInitial = Transaction(
    icon: "",
    bankName: "",
    date: DateTime.now(),

    typeMoney:"",

    transactionId: '', walletId: '', description: '', amount: 0, type: TransactionType.PAYMENT
  );
  ParkingLot selectedParkingLotInitial =
  ParkingLot(
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
  ParkingSlot selectedParkingSlotInitial =
      ParkingSlot(
          slotId: '',
          vehicleType: '',
          slotStatus: "",
          pricePerHour: 0,
          pricePerMonth: 0,
          parkingLotId: "", slotName: '');