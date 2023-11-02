import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med/ui/hospital.dart';

import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;


class HospitalNeeds extends ChangeNotifier {
  List<Hospital> notes = [];
  final String _rpcUrl =
      'http://127.0.0.1:7545';
  final String _wsUrl =
      'ws://127.0.0.1:7545';
  bool isLoading = true;

  final String _privatekey =
      '9543fe519913762759c8549b35bfc8b7c7b80f5a33b1503a798e639571b3b4b0';
  late Web3Client _web3cient;

  HospitalNeeds() {
    init();
  }

  Future<void> init() async {
    _web3cient = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    await getABI();
    await getCredentials();
    await getDeployedContract();
  }

  late ContractAbi _abiCode;
  EthereumAddress? _contractAddress;
  Future<void> getABI() async {
    String abiFile =
    await rootBundle.loadString('build/contracts/Hospital.json');
    var jsonABI = jsonDecode(abiFile);
    _abiCode =
        ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'Hospital');
    _contractAddress =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  late EthPrivateKey _creds;
  Future<void> getCredentials() async {
    _creds = EthPrivateKey.fromHex(_privatekey);
  }

  late DeployedContract _deployedContract;
  late ContractFunction _createNotes;
  late ContractFunction _deleteNotes;
  late ContractFunction _notes;
  late ContractFunction _notesCount;

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode, _contractAddress!);
    _createNotes = _deployedContract.function('createNotes');
    _deleteNotes = _deployedContract.function('deleteNotes');
    _notes = _deployedContract.function('notes');
    _notesCount = _deployedContract.function('notesCount');
    await fetchNotes();
  }

  Future<void> fetchNotes() async {
    List totalTaskList = await _web3cient.call(
      contract: _deployedContract,
      function: _notesCount,
      params: [],
    );

    int totalTaskLen = totalTaskList[0].toInt();
    notes.clear();
    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await _web3cient.call(
          contract: _deployedContract,
          function: _notes,
          params: [BigInt.from(i)]);
      if (temp[1] != "") {
        notes.add(
          Hospital(
            id: (temp[0] as BigInt).toInt(),
            title: temp[1],
            description: temp[2],
          ),
        );
      }
    }
    isLoading = false;

    notifyListeners();
  }

  Future<void> addNote(String title, String description) async {
    await _web3cient.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _deployedContract,
        function: _createNotes,
        parameters: [title, description],
      ),
    );
    isLoading = true;
    fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await _web3cient.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _deployedContract,
        function: _deleteNotes,
        parameters: [BigInt.from(id)],
      ),
    );
    isLoading = true;
    notifyListeners();
    fetchNotes();
  }
}



