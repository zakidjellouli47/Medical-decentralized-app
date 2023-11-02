import 'package:fluttertoast/fluttertoast.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class Connector {//creating a connector class to connect to the blockchain
  static late EthereumAddress address;// creating the public address type ethereum since it's an ethereum address
  static late String key;// creating the private key type string since it's a text of string
  static String blockchainUrl =
      "https://goerli.infura.io/v3/0ddff0afa41247e8bc5143435bd2e9ab";// creating the private blockchain url taken from
  // infura website using the goerli testnet


  static Client httpClient = Client();// creating the httpclient that handls the http requests
  static Web3Client ethClient = Web3Client(blockchainUrl, httpClient);// the web3 takes two parameters , the blockchain url
  // and the http client and the value is stored in the ethClient that means ethereum client

  static Future<DeployedContract> getContractPatient() async {// creating the future function that holds the deployed contract
   // of the patient
    String abiFilePatient =
    await rootBundle.loadString("assets/contracts/patient.json");// loading the abi file that holds the json information
    // after the contract was compiled in remix ide ,// root bundle function to load strings and json files from the assets
    String contractAddress = "0x96a01f7a79755e2300539cb8774f0d70406c0b71";//storing the contract address that was
    // created in the remix ide
    final contractPatient = DeployedContract(ContractAbi.fromJson(abiFilePatient, "Patient"), EthereumAddress.fromHex(contractAddress));
    // the deployed contract holds 2 parameters  , the abi file with the name of the contract and the ethereum contract address
     // the result will be held in the final variable contractPatient
    return contractPatient; // the return of the function is the variable contractPatient that
    //holds the deployed contract
  }

  static Future<DeployedContract> getContractDoctor() async {// creating the future function that holds the deployed contract
    // of the doctor
    String abiFileDoctor =
    await rootBundle.loadString("assets/contracts/doctor.json");
    // loading the abi file that holds the json information
    // after the contract was compiled in remix ide ,// root bundle function to load strings and json files from the assets
    String contractAddress = "0xe72d56743a3de6edc2e42695d08fbe081c9f26e8";//storing the contract address that was
    // created in the remix ide

    final contractDoctor = DeployedContract(ContractAbi.fromJson(abiFileDoctor, "Doctor"), EthereumAddress.fromHex(contractAddress));
    // the deployed contract holds 2 parameters  , the abi file with the name of the contract and the ethereum contract address
    // the result will be held in the final variable contractDoctor
    return contractDoctor; // the return of the function is the variable contractDoctor that
    //holds the deployed contract
  }

  static Future<bool> isDoctorExists(EthereumAddress address) async {// create the future function to check if the doctor
    //exists or not , it holds the public address as a parameter
    final contract = await getContractDoctor();// call the get contract doctor and store the contract in the final variable contract
    final result = await ethClient.call(// by using the ethClient that we created previously
      // by calling the contract and the function isDoctor along with the params of the function by using the
      // ethClient.call function and storing it in the final result variable
        contract: contract,// the contract
        function: contract.function("isDoctor"),// the function
        params: [address]);// the parameters of the function
    return result[0];// return the result as  dymanic list since the ethClient.call is a dynamic list
  }

  static Future<bool> isPatientExists(EthereumAddress address) async {// create the future function to check if the patient
  //exists or not , it holds the public address as a parameter
    final contract = await getContractPatient();// call the get contract patient and store the contract in the final variable contract
    final result = await ethClient.call(// by using the ethClient that we created previously
      // by calling the contract and the function isPatient along with the params of the function by using the
      // ethClient.call function and storing it in the final result variable
        contract: contract,// the contract
        function: contract.function("isPatient"),// the function
        params: [address]);// the parameters of the function
    return result[0];// return the result as  dymanic list since the ethClient.call is a dynamic list
  }

  static Future<String> getFee(EthereumAddress address) async {// create the future function to get the fee(bills)
    // it holds the public address as a parameter
    final contract = await getContractDoctor();//
    final result = await ethClient.call(//// by using the ethClient that we created previously
      // by calling the contract and the function getFee along with the params of the function by using the
      // ethClient.call function and storing it in the final result variable
        contract: contract,// the contract
        function: contract.function("getFee"),// the function
        params: [address]);// the parameters of the function
    return result[0].toString();
    // return the result as  dymanic list since the ethClient.call is a dynamic list
    // but put the toString since it the fee is an integer and the function returns a string
  }





  static Future<bool> isAuthorized(// create the future function to check if the doctor
      //is authorized to send data to the patient or not , it holds the public address  of the patient and doctor as  parameters
      EthereumAddress doc, EthereumAddress pat) async {
    final contract = await getContractPatient();// call the get contract patient and store the contract in the final variable contract
    final result = await ethClient.call(// by using the ethClient that we created previously
      // by calling the contract and the function isAuthorized along with the params of the function by using the
      // ethClient.call function and storing it in the final result variable
        contract: contract,// the contract
        function: contract.function("isAuthorized"),// the function
        params: [doc, pat]);// the parameters of the function
    return result[0];// return the result as  dymanic list since the ethClient.call is a dynamic list
  }




  static Future<dynamic> getPresc(EthereumAddress address) async {
    final contract = await getContractPatient();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("viewPrescription"),
        params: [address]);
    return result[0];
  }

  static Future<bool> logInDoctor(String address, String privateKey) async {// create the future function
    // to let the doctor enter his panel ,it holds two parameters the address and private key
    EthereumAddress addr = EthereumAddress.fromHex(address);//taking the address in hexadecimal and store it in the addr variable
    bool result = await isDoctorExists(addr);// check if the doctor exists by calling the function called isDoctor exists
    if (result == true) return true;// if the doctor exists than return true and let him enter his panel


    // if the doctor doesn't exist we will add him


    Credentials key = EthPrivateKey.fromHex(privateKey);//taking the privateKey in hexadecimal and store it in the key variable

    //obtain our contract from abi in json file
    final contract = await getContractDoctor();//

    // extract function from json file
    final function = contract.function("addDoctor");// calling the add doctor function in order to add the doctor

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
      key,// private key will be used to call the contract
      Transaction.callContract(
          contract: contract// the contract
          , function: function// the function
          , parameters: [addr]),//the add doctor function holds the address as a parameter
      chainId: 5,// goerli test net has a 5 chain id
    );
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isDoctorExists(addr);// after adding the doctor calling the exist doctor function and hold it in the result
    return result;// return the result
  }

  static Future<bool> logInPatient(String address, String privateKey) async {//// create the future function
    // to let the patient enter his panel ,it holds two parameters the address and private key

    EthereumAddress addr = EthereumAddress.fromHex(address);//taking the address in hexadecimal and store it in the addr variable
    bool result = await isPatientExists(addr);// check if the patient exists by calling the function called isDoctor exists
    if (result == true) return true;// if the patient exists than return true and let him enter his panel
    Credentials key = EthPrivateKey.fromHex(privateKey);//taking the privateKey in hexadecimal and store it in the key variable

    //obtain our contract from abi in json file
    final contract = await getContractPatient();

    // extract function from json file
    final function = contract.function("addPatient");// calling the add doctor function in order to add the patient

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
      key,// private key will be used to call the contract
      Transaction.callContract(
          contract: contract// the contract
          , function: function// the function
          , parameters: [addr]),//the add patient function holds the address as a parameter
      chainId: 5,// goerli test net has a 5 chain id
    );
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isPatientExists(addr);// after adding the patient calling the exist patient function and hold it in the result
    return result;// return the result
  }

  static Future<String> updateDoctorFee(// create the future function to update the fee(bills) , the function returns string
      EthereumAddress address, String privateKey, String amount) async {
    // it holds 3 parameters the address and private key and the amount which is the balance
    Credentials key = EthPrivateKey.fromHex(privateKey);//taking the privateKey in hexadecimal and store it in the key variable

    //obtain our contract from abi in json file
    final contract = await getContractDoctor();

    // extract function from json file
    final function = contract.function("updateFee");// calling the update fee function in order to update the fee(bills)

    //send transaction using the our private key, function and contract

    await ethClient.sendTransaction(
        key,// private key will be used to call the contract
        Transaction.callContract(
            contract: contract,// contract
            function: function,// function
            parameters: [address, BigInt.parse(amount)]),// the parameters of the update function are address and the amount
        // which is converted to a bigInt to hold bigger numbers by using the parse function
        chainId: 5);// goerli test net has a 5 chain id

    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});

    String result = await getFee(address);//after the update call the get fee function and store it in the result variable
    return result;// return the result fee
  }

  static Future<bool> addAuthorization(
      // create the future function
      // to let the doctor sends the medical record to the patient ,it holds two parameters the addresses of the
      //  patient and doctor and  the private key

      EthereumAddress doc, EthereumAddress pat, String privateKey) async {
    bool result = await isAuthorized(doc, pat);// calling the function is authorized to verify if the doctor has
    // been authorized or not
    if (result) return true;// if the result is true that means the doctor is authorized
    String fee = await getFee(doc);// calling the get fee function in order to get the fee and storing it in string fee

    Credentials key = EthPrivateKey.fromHex(privateKey);//taking the privateKey in hexadecimal and store it in the key variable

    //obtain our contract from abi in json file
    final contract = await getContractPatient();

    // extract function from json file
    final function = contract.function("addAuthorization");// calling the add authorization function from json file

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
        key,// private key will be used to call the contract
        Transaction.callContract(
            value: EtherAmount.fromUnitAndValue(EtherUnit.wei, fee),//the fee is taken as wei value which is a small value of
            // ethers
            contract: contract,//  contract
            function: function,// function
            parameters: [doc, pat, BigInt.parse(fee)]),

        // the parameters of the add authorization function are address doc and pat and the fee
        // which is converted to a bigInt to hold bigger numbers by using the parse function
        chainId: 5);// goerli test net has a 5 chain id
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isAuthorized(doc, pat);//after performing  the add authorization function to the doctor
    // we all the function is authorized
    // to return the message that the doctor is now authorized
    return result;// return the result
  }

   static Future<void> setPresc(EthereumAddress doc, EthereumAddress pat,
      String privateKey, String prescription) async {
    // create the future function to set the prescription , it  returns nothing
    //it holds the Address doc and pat and the private key and the prescription
    if (await isAuthorized(doc, pat)) {// calling the is authorized function to
      //check if the doctor is authorized by the patient
      Credentials key = EthPrivateKey.fromHex(privateKey);//taking the privateKey in hexadecimal and store it in the key variable

      //obtain our contract from abi in json file
      final contract = await getContractPatient();

      // extract function from json file
      final function = contract.function("setPrescription");
      // calling the set Prescription function from json file

      //send transaction using the our private key, function and contract
      await ethClient.sendTransaction(
          key,// private key will be used to call the contract
          Transaction.callContract(
              contract: contract,//  contract
              function: function,// function
              parameters: [prescription, pat, doc]),// the parameters of the set Prescription function are address doc and pat and the presc
          chainId: 5);// goerli test net has a 5 chain id
    } else {
      Fluttertoast.showToast(msg: "You are not authorized yet to send medical records");
    }
  }
}
