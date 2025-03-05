// ignore_for_file: file_names





import 'package:myparkingapp/data/model/image.dart';
import 'package:myparkingapp/data/model/vehicle.dart';

import '../../data/model/parkingLot.dart';
import '../../data/model/parkingSlot.dart';
import '../../data/model/transaction.dart';
import '../../data/model/user.dart';
import '../../data/model/wallet.dart';

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
    status: UserStatus.ACTIVE, roles: [],
  );
  User selectedLotOwnerInitial = User(
    phoneNumber: '',
    homeAddress: '',
    companyAddress: '',
    lastName: '',
    firstName: '',
    avatar: '',
    email: '',
    status: UserStatus.ACTIVE, username: '', roles: ['USER'], userId: '', password: '',
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
    transactionId: '',
    walletId: '', description: '', amount: 0, type: Transactions.PAYMENT, status: TransactionStatus.COMPLETED
  );
  ParkingLot selectedParkingLotInitial =
  ParkingLot(
      userId: "1",
      status: lotStatus.ON,
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
          vehicleType: VehicleType.MOTORCYCLE,
          status: slotStatus.AVAILABLE,
          pricePerHour: 0,
          pricePerMonth: 0,
          parkingLotId: "", slotName: '', floorName: '');
  Images selectedImagesInitial =  Images(url: '', imageId: '', parkingLotId: '', userId: '');