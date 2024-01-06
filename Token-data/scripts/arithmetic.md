294 results - 220 files

Token-data/result/0x000ae26329aa0c57b9badbdee2996624272905e9-TokenMintERC20Token.inv.json:
  491              "VeriSol.Ensures(_totalSupply != _balances[msg.sender])",
  492:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  493          ]

Token-data/result/0x0d8c6c3fc05be8483172fa6cd0131ee7dc8e8e05-TokenMintERC20Token.inv.json:
  391              "VeriSol.Ensures(_balances[msg.sender] >= msg.value)",
  392:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  393          ]

Token-data/result/0x1d2dac9a2582e35463c12cd5fdf175afc7bb4f3a-SocialMoney.inv.json:
  692              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(uint256(decimals)))",
  693:             "VeriSol.Ensures(value + VeriSol.Old(_balances[to]) == _balances[to])"
  694          ]

Token-data/result/0x1f25ada422b1c54643996b3751dfa0f008f543b8-TokenMintERC20Token.inv.json:
  859              "VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply)",
  860:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  861          ]

Token-data/result/0x1ff2e3bac33af1696b60903ce55b8063d52f22e0-RaichuToken.inv.json:
  419              "VeriSol.Ensures(_balances[recipient] != VeriSol.Old(_balances[msg.sender]))",
  420:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  421          ]

Token-data/result/0x2db07f061f12f1ef51c49b02ad5a3eb71f60b69e-SocialMoney.inv.json:
  556              "VeriSol.Ensures(decimals != msg.value)",
  557:             "VeriSol.Ensures(VeriSol.Old(_balances[from]) - _balances[from] == value)",
  558:             "VeriSol.Ensures(VeriSol.Old(_balances[to]) + value == _balances[to])"
  559          ]

  775              "VeriSol.Ensures(decimals != VeriSol.Old(_balances[msg.sender]))",
  776:             "VeriSol.Ensures(VeriSol.Old(_balances[to]) + value == _balances[to])"
  777          ]

Token-data/result/0x3fa18875876794040105ff06dd50662d8e4b3054-TokenMintERC20Token.inv.json:
  575              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _balances[recipient])",
  576:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)",
  577:             "VeriSol.Ensures(_balances[recipient] - VeriSol.Old(_balances[recipient]) == amount)"
  578          ]

Token-data/result/0x4c6719bf85903d18c295da44216f862b01b36f43-AlloHash.inv.json:
  637              "VeriSol.Ensures(VeriSol.SumMapping(balances) != balances[msg.sender])",
  638:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])",
  639:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  640          ]

Token-data/result/0x4d935d75889c0ce66aa50aac50508af502d6eb86-BezosBucks.inv.json:
  1333              "VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] != value)",
  1334:             "VeriSol.Ensures(value + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  1335          ]

Token-data/result/0x4de9622458d05abcaf3970b9369eb50b6d2b4018-SENDit.inv.json:
  524              "VeriSol.Ensures(balances[to] != msg.value)",
  525:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  526          ]

Token-data/result/0x4ee1bb7c19bc332d1b172a64a027dd8a5560ec5a-TokenMintERC20Token.inv.json:
  448              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != _totalSupply)",
  449:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  450          ]

Token-data/result/0x04f33d09aae7923fcd82590b1d8fef0ce41936e1-BasedPepe.inv.json:
  360              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != balances[msg.sender])",
  361:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  362          ]

Token-data/result/0x5e5948c6a1c48b5b6a19852928af3b72e974ef8d-BigBabyInu.inv.json:
  845              "VeriSol.Ensures(balances[msg.sender] != balances[to])",
  846:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  847          ]

Token-data/result/0x6a137df19d3e987e3207e8c94387bece89d385f8-SACHS.inv.json:
  671              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances))",
  672:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  673          ]

Token-data/result/0x6f95df342e9d336275b05b1d7a43459c26be1963-TokenMintERC20Token.inv.json:
  397              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) != _decimals)",
  398:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  399:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  400          ]

Token-data/result/0x7b52118bcd20d43861cdb112150a9b0342677d3b-TokenMintERC20Token.inv.json:
  566              "VeriSol.Ensures(_balances[sender] != amount)",
  567:             "VeriSol.Ensures(amount + _balances[sender] == VeriSol.Old(_balances[sender]))"
  568          ]

Token-data/result/0x07bc8d1a87c2b7caa596abce2d5bb41efc475c5c-InfernoHound.inv.json:
  857              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _totalSupply)",
  858:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  859          ]

Token-data/result/0x7c5ff719a6c76fe643e9ecd0f11f146a2de05f14-GaneshaToken.inv.json:
  389              "VeriSol.Ensures(decimals != VeriSol.Old(balances[msg.sender]))",
  390:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  391          ]

Token-data/result/0x7d755944d44fc8b5183b82f55889b3fbe9bebb8d-PBull.inv.json:
  19136              "VeriSol.Ensures(VeriSol.Old(UniLP) != _pairUSD)",
  19137:             "VeriSol.Ensures(_updatedBalance[msg.sender] + value == VeriSol.Old(_updatedBalance[msg.sender]))"
  19138          ]

Token-data/result/0x8c867db31072f160cbfe1311d8a6cd85806dd6b4-Zeus.inv.json:
  1481              "VeriSol.Ensures(_decimals != VeriSol.Old(_balances[msg.sender]))",
  1482:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == value)"
  1483          ]

Token-data/result/0x8de4644406933728ac9df5bc648d1482fb628406-TokenMintERC20Token.inv.json:
  696              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _balances[msg.sender])",
  697:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  698          ]

Token-data/result/0x8ec39e54303269cfea50bb0555cf7a73fd933f73-TokenMintERC20Token.inv.json:
  1050              "VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply))",
  1051:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  1052          ]

Token-data/result/0x8f12dfc7981de79a8a34070a732471f2d335eece-CryptoExcellence.inv.json:
  659              "VeriSol.Ensures(decimals != balances[to])",
  660:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  661          ]

Token-data/result/0x9ab8432a7794566c27f051c087adedbf64337eea-GrandTheftArlen.inv.json:
  918              "VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_balances))",
  919:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  920          ]

Token-data/result/0x09e333e720e1bd0fe82d188d6aed36d22f96d399-StandardERC20Token.inv.json:
  589              "VeriSol.Ensures(_totalSupply != VeriSol.Old(_balances[recipient]))",
  590:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  591          ]

Token-data/result/0x9e0796c4146cd6ce77a9e1f77f2c3f21190a9055-TokenMintERC20Token.inv.json:
  371              "VeriSol.Ensures(VeriSol.Old(_totalSupply) != _decimals)",
  372:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  373          ]

Token-data/result/0x24da31e7bb182cb2cabfef1d88db19c2ae1f5572-TokenMintERC20Token.inv.json:
  340              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != VeriSol.SumMapping(_balances))",
  341:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  342          ]

Token-data/result/0x28c5d11436cf68fb0e7b21bb0c570f9ec62199a1-TokenMintERC20Token.inv.json:
  716              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != amount)",
  717:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  718          ]

Token-data/result/0x32f9308c831bc74a8bcc675148e78340d812a976-BullRider.inv.json:
  586              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(uint256(_decimals)))",
  587:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  588          ]

Token-data/result/0x38c97cbd6e986798207b4b29ecf01ea8977b7256-Hypano.inv.json:
  381              "VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply))",
  382:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  383          ]

Token-data/result/0x43b0bc65935a59ec7d6ce15e6d3112691a8e1dd9-TokenMintERC20Token.inv.json:
  1036              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _decimals)",
  1037:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  1038          ]

Token-data/result/0x47d920a911cb9a0ad4618698ba3fef800abc868d-TokenMintERC20Token.inv.json:
  409              "VeriSol.Ensures(VeriSol.Old(_allowances[sender][msg.sender]) != _decimals)",
  410:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  411          ]

Token-data/result/0x48cd2a4947aa70251654312a2cbfa99663560cbd-CodeWithJoe.inv.json:
  687              "VeriSol.Ensures(balances[msg.sender] != msg.value)",
  688:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])"
  689          ]

Token-data/result/0x51fa8077fdd878ccce56912c3cb7fb9a87d0eeaa-CodeWithJoe.inv.json:
  375              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != balances[to])",
  376:             "VeriSol.Ensures(balances[to] - tokens == VeriSol.Old(balances[to]))",
  377:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  378          ]

Token-data/result/0x56df7dd5e6476af94666e856c38aefc4d4555861-DinosaurERC20Token.inv.json:
  425              "VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(_balances))",
  426:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[recipient])",
  427:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  428:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  429          ]

Token-data/result/0x61d45f5475d90af0c3b3f3673beb18b43284dce7-YCCToken.inv.json:
  215              "VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances))",
  216:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  217          ]

Token-data/result/0x62c23c5f75940c2275dd3cb9300289dd30992e59-TokenMintERC20Token.inv.json:
  262              "VeriSol.Ensures(_decimals != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  263:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  264          ]

Token-data/result/0x62c8179b08b72acd4e745b33415aa512f2aa4097-TheHound.inv.json:
  672              "VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(uint256(decimals)))",
  673:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])",
  674:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  675          ]

Token-data/result/0x72f0c5d7fb01506543c2880e1a7f808e0a81febf-DogeFather.inv.json:
  395              "VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(_totalSupply))",
  396:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  397          ]

Token-data/result/0x75de9fa3e18071eab22823d6c2bcecde759250ca-BURN.inv.json:
  906              "VeriSol.Ensures(_totalSupply != msg.value)",
  907:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  908          ]

Token-data/result/0x80e9dd5d9c01082f4ff1620f0d19c8b95307403e-InuClassic.inv.json:
  709              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != _balances[msg.sender])",
  710:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  711:             "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) - amount == _balances[recipient])",
  712:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  713          ]

Token-data/result/0x81b3e4111b0aab36b3fd679e04e84e38931244bb-KillerShiba.inv.json:
  360              "VeriSol.Ensures(VeriSol.Old(balances[to]) != VeriSol.SumMapping(balances))",
  361:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  362          ]

Token-data/result/0x85a65e23105d1b3538ceb463edfdfc3d9af179a8-SocialMoney.inv.json:
  253              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != _balances[to])",
  254:             "VeriSol.Ensures(_balances[to] - VeriSol.Old(_balances[to]) == value)"
  255          ]

Token-data/result/0x97b3c9aa2ddf4d215a71090c1ee5990e2ad60fd1-SteveJobs.inv.json:
  590              "VeriSol.Ensures(msg.value != allowed[from][msg.sender])",
  591:             "VeriSol.Ensures(tokens + balances[from] == VeriSol.Old(balances[from]))",
  592:             "VeriSol.Ensures(VeriSol.Old(allowed[from][msg.sender]) - tokens == balances[from])",
  593:             "VeriSol.Ensures(allowed[from][msg.sender] + tokens == VeriSol.Old(balances[from]))",
  594:             "VeriSol.Ensures(allowed[from][msg.sender] + tokens == VeriSol.Old(allowed[from][msg.sender]))"
  595          ]

Token-data/result/0x161cddfb1fb7921a01d45c147f44670bb060ace5-TokenMintERC20Token.inv.json:
  442              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != _balances[recipient])",
  443:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  444          ]

Token-data/result/0x509ed91b94972adc72bf7a7b326cfa6ba6378e7e-LilShiba.inv.json:
  842              "VeriSol.Ensures(_totalSupply != amount)",
  843:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))",
  844:             "VeriSol.Ensures(amount - VeriSol.Old(_balances[recipient]) == _balances[msg.sender])",
  845:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  846          ]

Token-data/result/0x514d27336b4f80419e20d2a772d14efede22f245-TokenMintERC20Token.inv.json:
  544              "VeriSol.Ensures(amount != _balances[msg.sender])",
  545:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  546          ]

Token-data/result/0x547dd0dc34f446d91fb5e270cbdf4198cca30bc6-SocialMoney.inv.json:
  406              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) <= VeriSol.SumMapping(_balances))",
  407:             "VeriSol.Ensures(_balances[to] - VeriSol.Old(_balances[to]) == value)"
  408          ]

Token-data/result/0x617b0e7d37b5cd55ad584c7e806a71c64ecc2a28-TokenMintERC20Token.inv.json:
  424              "VeriSol.Ensures(_totalSupply != VeriSol.Old(_balances[recipient]))",
  425:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))",
  426:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  427          ]

Token-data/result/0x642fab3778de79df3e0f9e21694c7d90e07f6ea3-AKAMARU.inv.json:
  961              "VeriSol.Ensures(basePercent != VeriSol.Old(_balances[to]))",
  962:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - value == _balances[msg.sender])"
  963          ]

Token-data/result/0x669b2360e3e33d0b4d60cbe05a5cdc0c0f2e8346-SAFEPEPPA.inv.json:
  1949              "VeriSol.Ensures(_balances[to] != VeriSol.Old(_burnStopAmount))",
  1950:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == value)"
  1951          ]

Token-data/result/0x766d4c9c1c7316e97968a36b7b01bf7fcda7feb6-KogiInuToken.inv.json:
  487              "VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(_totalSupply))",
  488:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  489          ]

Token-data/result/0x911f5e6b29ae4f9c8f1c3d179b9b249bba6d8262-TokenMintERC20Token.inv.json:
  549              "VeriSol.Ensures(_totalSupply != amount)",
  550:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  551          ]

Token-data/result/0x968afac04e82e186f2135ce689cd775084016c35-TokenMintERC20Token.inv.json:
  387              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(_balances[recipient]))",
  388:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  389:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  390          ]

Token-data/result/0x3130dd4efcfd51166934039cb5747707a55f3a5e-GuideAmbassador.inv.json:
  365              "VeriSol.Ensures(_totalSupply != VeriSol.Old(balances[msg.sender]))",
  366:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])",
  367:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  368          ]

Token-data/result/0x3301ee63fb29f863f2333bd4466acb46cd8323e6-AKITAERC20Token.inv.json:
  412              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) <= VeriSol.SumMapping(_balances))",
  413:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  414          ]

Token-data/result/0x3622d034fbf3baec7060c7cb484a121389684986-RyukyuInuERC20Token.inv.json:
  550              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) != _totalSupply)",
  551:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  552          ]

Token-data/result/0x4804fb55e75bd1c32ab06cd053c5510c1b80fd26-SocialMoney.inv.json:
  425              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != _totalSupply)",
  426:             "VeriSol.Ensures(VeriSol.Old(_allowed[from][msg.sender]) - value == _allowed[from][msg.sender])",
  427:             "VeriSol.Ensures(VeriSol.Old(_balances[from]) - value == _balances[from])"
  428          ]

Token-data/result/0x5672f74741549428e38a440fd73d90fc8364e863-TokenMintERC20Token.inv.json:
  606              "VeriSol.Ensures(Account == VeriSol.Old(Account))",
  607:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  608          ]

Token-data/result/0x8037fbdb3a8b4befdd40fcd75e899b2aba5bf5a3-TokenMintERC20Token.inv.json:
  399              "VeriSol.Ensures(_decimals <= VeriSol.Old(_totalSupply))",
  400:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))",
  401:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  402          ]

Token-data/result/0x9682e720ddf3b8c667966a72bb62649c58a53d5e-DOGHOUSE.inv.json:
  1533              "VeriSol.Ensures(basePercent != msg.value)",
  1534:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  1535          ]

Token-data/result/0x56366ce135cc5f636365f11e4e3450ef03241c44-Bone.inv.json:
  502              "VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(balances[msg.sender]))",
  503:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  504          ]

Token-data/result/0x70665f330191abababc772f5e51ba1ecf61672ef-TokenMintERC20Token.inv.json:
  690              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(_totalSupply))",
  691:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  692          ]

Token-data/result/0x78689fd6ecd9c168b2ba69ff022ff70302f0bba7-BLOCKYDOGE.inv.json:
  394              "VeriSol.Ensures(msg.value != balances[msg.sender])",
  395:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])",
  396:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  397          ]

Token-data/result/0x299209fa44d48863c84125bbae12676ed6ce8e97-TokenMintERC20Token.inv.json:
  404              "VeriSol.Ensures(_decimals != _balances[recipient])",
  405:             "VeriSol.Ensures(_balances[recipient] - VeriSol.Old(_balances[recipient]) == amount)"
  406          ]

Token-data/result/0x378385c2f2ab9052e38d9cb4025ebf696c17b291-ECTONETWORK.inv.json:
  359              "VeriSol.Ensures(_totalSupply != msg.value)",
  360:             "VeriSol.Ensures(balances[to] - VeriSol.Old(balances[to]) == tokens)"
  361          ]

Token-data/result/0x380724fa326ef4a616798e67ac042b2b647decd3-SpartanGlobalCoin.inv.json:
  351              "VeriSol.Ensures(decimals != tokens)",
  352:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])"
  353          ]

Token-data/result/0x3781731acd887b14d7f7f261f3aada7f6405868a-Arcanite.inv.json:
  340              "VeriSol.Ensures(_totalSupply != balances[msg.sender])",
  341:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  342          ]

Token-data/result/0x6466165ef085c4b5bc9c978397b128a85d12c184-TokenMintERC20Token.inv.json:
  336              "VeriSol.Ensures(_balances[msg.sender] != _decimals)",
  337:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(VeriSol.SumMapping(_balances)))",
  338:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))",
  339:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_totalSupply))"
  340          ]

  561              "VeriSol.Ensures(_balances[msg.sender] != _decimals)",
  562:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  563          ]

Token-data/result/0x6767615a97a8204298bbac44c57ef1a615eed244-CribnbERC20.inv.json:
  372              "VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances))",
  373:             "VeriSol.Ensures(VeriSol.Old(balances[from]) - tokens == balances[from])",
  374:             "VeriSol.Ensures(tokens + allowed[from][msg.sender] == VeriSol.Old(allowed[from][msg.sender]))"
  375          ]

Token-data/result/0x7302429c53c54d15328e3e393d52d005e9759355-XINU.inv.json:
  400              "VeriSol.Ensures(_balances[msg.sender] >= msg.value)",
  401:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  402          ]

Token-data/result/0x7631127e358517e3b15903bbcb0f50a45a4379db-SING.inv.json:
  358              "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) != VeriSol.SumMapping(balances))",
  359:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  360          ]

Token-data/result/0x62406995cafd18f57e7375e8e0060725acebce58-FirulaisWalletToken.inv.json:
  614              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != msg.value)",
  615:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))",
  616:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  617          ]

Token-data/result/0x78132543d8e20d2417d8a07d9ae199d458a0d581-TokenMintERC20Token.inv.json:
  730              "VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)))",
  731:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  732          ]

Token-data/result/0x836775359fd7b19409f2914719c67e4db7073eab-TokenMintERC20Token.inv.json:
  452              "VeriSol.Ensures(_decimals != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  453:             "VeriSol.Ensures(VeriSol.Old(_allowances[msg.sender][spender]) + addedValue == _allowances[msg.sender][spender])"
  454          ]

  633              "VeriSol.Ensures(_decimals != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  634:             "VeriSol.Ensures(VeriSol.Old(_allowances[msg.sender][spender]) - _allowances[msg.sender][spender] == subtractedValue)"
  635          ]

Token-data/result/0x846132977b441bcbaeeefb79e056f7c5be8fcdf3-TokenMintERC20Token.inv.json:
  392              "VeriSol.Ensures(_decimals != amount)",
  393:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  394          ]

Token-data/result/0x4333993025af6475b86e18e3ef8b371bb5966ec8-TokenMintERC20Token.inv.json:
  358              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != _balances[msg.sender])",
  359:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))",
  360:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  361          ]

Token-data/result/0x56779592815d1d9298d5c88fc64413b1eaaf00dc-CodeWithJoe.inv.json:
  344              "VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(_totalSupply))",
  345:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])"
  346          ]

Token-data/result/0xa1a7a1c19e6cc4c79ea5f4b344181cf1be07e6d6-TokenMintERC20Token.inv.json:
  570              "VeriSol.Ensures(_balances[recipient] <= amount)",
  571:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  572          ]

Token-data/result/0xa25c780132be018a4064f0aa62ff54a32687ae14-Bone.inv.json:
  356              "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) <= VeriSol.SumMapping(balances))",
  357:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  358          ]

Token-data/result/0xad27a16d8835d880d4c8c5c17a4b6fd8ad1811a7-SocialMoney.inv.json:
  252              "VeriSol.Ensures(_balances[msg.sender] != value)",
  253:             "VeriSol.Ensures(value + VeriSol.Old(_balances[to]) == _balances[to])"
  254          ]

Token-data/result/0xb6a3fb9a636f6f3b22c06c8ba62b63d7d499fa15-TokenMintERC20Token.inv.json:
  416              "VeriSol.Ensures(_balances[recipient] != msg.value)",
  417:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  418          ]

Token-data/result/0xb77ffbb00f4c529747bab93bdeb3dce49b021e76-SafeDawg.inv.json:
  514              "VeriSol.Ensures(balances[msg.sender] != _totalSupply)",
  515:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])"
  516          ]

Token-data/result/0xb934c43268adaedee892c4e8d3d56b010498e80c-clashPay.inv.json:
  1181              "VeriSol.Ensures(_to != Tokenfarm)",
  1182:             "VeriSol.Ensures(_value + balanceOf[msg.sender] == VeriSol.Old(balanceOf[msg.sender]))"
  1183          ]

Token-data/result/0xb874921bfc23e4800a72d0108458cb14ccd12601-PreciousMetalCapital.inv.json:
  590              "VeriSol.Ensures(VeriSol.Old(_balances[sender]) != _allowances[sender][msg.sender])",
  591:             "VeriSol.Ensures(_allowances[sender][msg.sender] + amount == VeriSol.Old(_allowances[sender][msg.sender]))"
  592          ]

Token-data/result/0xb2923909b5d8bbe01505121f15a4503b6617dae7-WrappedHeC.inv.json:
  221              "VeriSol.Ensures(_totalSupply != balances[to])",
  222:             "VeriSol.Ensures(balances[to] - VeriSol.Old(balances[to]) == tokens)"
  223          ]

Token-data/result/0xb7131835d3fc64bcb1976733e28af8364d328f5c-DOGKINGERC20Token.inv.json:
  410              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  411:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  412          ]

Token-data/result/0xc5ba8e0afbbc9eedcd9f8c780e36369b0769ee52-DRAKON.inv.json:
  418              "VeriSol.Ensures(msg.value != _decimals)",
  419:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  420          ]

Token-data/result/0xc8b98f0030ef771b18f2bcb77964111f2889ebd3-FuckSellers.inv.json:
  9689              "VeriSol.Ensures(_updatedBalance[LastBuyer] != VeriSol.Old(_updatedBalance[NextVault]))",
  9690:             "VeriSol.Ensures(_updatedBalance[VeriSol.Old(LastBuyer)] - value == VeriSol.Old(_updatedBalance[LastBuyer]))",
  9691:             "VeriSol.Ensures(_updatedBalance[LastBuyer] - value == VeriSol.Old(_updatedBalance[LastBuyer]))",
  9692:             "VeriSol.Ensures(value + VeriSol.Old(_updatedBalance[to]) == _updatedBalance[to])",
  9693:             "VeriSol.Ensures(_updatedBalance[VeriSol.Old(LastBuyer)] - value == VeriSol.Old(RestValue))",
  9694:             "VeriSol.Ensures(_updatedBalance[LastBuyer] - value == VeriSol.Old(RestValue))",
  9695:             "VeriSol.Ensures(_updatedBalance[msg.sender] + value == VeriSol.Old(_updatedBalance[msg.sender]))",
  9696:             "VeriSol.Ensures(_updatedBalance[VeriSol.Old(LastBuyer)] - value == VeriSol.Old(_updatedBalance[VeriSol.Old(LastBuyer)]))",
  9697:             "VeriSol.Ensures(_updatedBalance[LastBuyer] - value == VeriSol.Old(_updatedBalance[VeriSol.Old(LastBuyer)]))"
  9698          ]

Token-data/result/0xc45efe8b705c97e9d49612443ccb10aec52a2543-ProofOfRyoshi.inv.json:
  430              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != _balances[recipient])",
  431:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  432          ]

Token-data/result/0xc8705424948e97e6db98022ba81bca5164660c82-KogiInuToken.inv.json:
  391              "VeriSol.Ensures(decimals != VeriSol.Old(balances[msg.sender]))",
  392:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  393          ]

Token-data/result/0xcaec28836b84f8b5c533983799fd78412fb4395a-TokenMintERC20Token.inv.json:
  429              "VeriSol.Ensures(_totalSupply != _balances[msg.sender])",
  430:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  431          ]

Token-data/result/0xce5860c82d49037efdfe300c7488263298a93501-RickRoll.inv.json:
  370              "VeriSol.Ensures(decimals != balances[to])",
  371:             "VeriSol.Ensures(balances[to] - tokens == VeriSol.Old(balances[to]))",
  372:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  373          ]

Token-data/result/0xcfa6ab49f69800b877070f231f22496249990cee-Brahma.inv.json:
  813              "VeriSol.Ensures(VeriSol.SumMapping(balances) != tokens)",
  814:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])"
  815          ]

Token-data/result/0xcfa1279b6a3860493f64cce1344f4e9c825113e4-GOCP.inv.json:
  191              "VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(balances[msg.sender]))",
  192:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) + _value == balances[msg.sender])"
  193          ]

Token-data/result/0xd50e079db8d18d594144108077f945218999acb0-TokenMintERC20Token.inv.json:
  448              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) <= _balances[msg.sender])",
  449:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  450          ]

Token-data/result/0xd83ea66d2ec74617734e82a39e7fe90496599204-SocialMoney.inv.json:
  371              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(_balances[msg.sender]))",
  372:             "VeriSol.Ensures(_balances[to] - value == VeriSol.Old(_balances[to]))"
  373          ]

Token-data/result/0xda6f3e151596cdc0c504e14932496ab8b2050895-FlowerToken.inv.json:
  359              "VeriSol.Ensures(tokens != balances[msg.sender])",
  360:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  361          ]

Token-data/result/0xdeb14c17e9c8ed4c64a2194e7758a072af69ef89-TokenMintERC20Token.inv.json:
  614              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  615:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  616          ]

Token-data/result/0xe4f6d46c244bb7cf3e218cdfb5c35cf9a4d9c920-Donkey.inv.json:
  376              "VeriSol.Ensures(_totalSupply != VeriSol.Old(VeriSol.SumMapping(balances)))",
  377:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  378          ]

Token-data/result/0xe09fb60e8d6e7e1cebbe821bd5c3fc67a40f86bf-PikachuToken.inv.json:
  599              "VeriSol.Ensures(VeriSol.Old(_totalSupply) != _balances[recipient])",
  600:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  601          ]

Token-data/result/0xe774959acd78a33ab7730b44a9455fb99d5a7ea8-MXSamurai.inv.json:
  527              "VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != _totalSupply)",
  528:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  529          ]

Token-data/result/0xea75671ab1d5c71b29399c0c4eccd5a9dbe41370-TokenMintERC20Token.inv.json:
  348              "VeriSol.Ensures(_decimals != amount)",
  349:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  350          ]

Token-data/result/0xeb2fce02460b095f7b084081c4799db0fb0b8a84-Cheese2.inv.json:
  877              "VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)))",
  878:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  879          ]

Token-data/result/0xec4a1c7a4e9fdc7cc621b548a931c92bc08a679a-Goji.inv.json:
  350              "VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(_totalSupply))",
  351:             "VeriSol.Ensures(balances[to] - tokens == VeriSol.Old(balances[to]))"
  352          ]

Token-data/result/0xeef7eaa73cab2f07f8ecee246f479a76139e236d-MyloToken.inv.json:
  367              "VeriSol.Ensures(_totalSupply != balances[to])",
  368:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  369          ]

Token-data/result/0xf4c3a87ce0e92dadd82b494bcefd0cdeca9b03dd-SAFEKONG.inv.json:
  915              "VeriSol.Ensures(_decimals != VeriSol.Old(_balances[msg.sender]))",
  916:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == value)"
  917          ]

Token-data/result/0xf8ccad1b25a54ce12f1b1ee56ef0f2a930d3e969-Finder.inv.json:
  475              "VeriSol.Ensures(decimals != VeriSol.Old(totalSupply_))",
  476:             "VeriSol.Ensures(_value + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  477          ]

Token-data/result/0xf61ae54b74a37be4fc11e9f1a35021848d996afc-EmaxClassic.inv.json:
  379              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) >= _balances[recipient])",
  380:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  381          ]

Token-data/result/0xff354e95d1120ae2d9e5db4c1cd18da7d976f1b7-TokenMintERC20Token.inv.json:
  422              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= VeriSol.SumMapping(_balances))",
  423:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  424          ]

verisol_test/0x000ae26329aa0c57b9badbdee2996624272905e9-TokenMintERC20Token.inv.json:
  491              "VeriSol.Ensures(_totalSupply != _balances[msg.sender])",
  492:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  493          ]

verisol_test/0x0d8c6c3fc05be8483172fa6cd0131ee7dc8e8e05-TokenMintERC20Token.inv.json:
  391              "VeriSol.Ensures(_balances[msg.sender] >= msg.value)",
  392:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  393          ]

verisol_test/0x1d2dac9a2582e35463c12cd5fdf175afc7bb4f3a-SocialMoney.inv.json:
  692              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(uint256(decimals)))",
  693:             "VeriSol.Ensures(value + VeriSol.Old(_balances[to]) == _balances[to])"
  694          ]

verisol_test/0x1f25ada422b1c54643996b3751dfa0f008f543b8-TokenMintERC20Token.inv.json:
  859              "VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply)",
  860:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  861          ]

verisol_test/0x1ff2e3bac33af1696b60903ce55b8063d52f22e0-RaichuToken.inv.json:
  419              "VeriSol.Ensures(_balances[recipient] != VeriSol.Old(_balances[msg.sender]))",
  420:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  421          ]

verisol_test/0x2db07f061f12f1ef51c49b02ad5a3eb71f60b69e-SocialMoney.inv.json:
  556              "VeriSol.Ensures(decimals != msg.value)",
  557:             "VeriSol.Ensures(VeriSol.Old(_balances[from]) - _balances[from] == value)",
  558:             "VeriSol.Ensures(VeriSol.Old(_balances[to]) + value == _balances[to])"
  559          ]

  775              "VeriSol.Ensures(decimals != VeriSol.Old(_balances[msg.sender]))",
  776:             "VeriSol.Ensures(VeriSol.Old(_balances[to]) + value == _balances[to])"
  777          ]

verisol_test/0x3fa18875876794040105ff06dd50662d8e4b3054-TokenMintERC20Token.inv.json:
  575              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _balances[recipient])",
  576:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)",
  577:             "VeriSol.Ensures(_balances[recipient] - VeriSol.Old(_balances[recipient]) == amount)"
  578          ]

verisol_test/0x4c6719bf85903d18c295da44216f862b01b36f43-AlloHash.inv.json:
  637              "VeriSol.Ensures(VeriSol.SumMapping(balances) != balances[msg.sender])",
  638:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])",
  639:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  640          ]

verisol_test/0x4d935d75889c0ce66aa50aac50508af502d6eb86-BezosBucks.inv.json:
  1333              "VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] != value)",
  1334:             "VeriSol.Ensures(value + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  1335          ]

verisol_test/0x4de9622458d05abcaf3970b9369eb50b6d2b4018-SENDit.inv.json:
  524              "VeriSol.Ensures(balances[to] != msg.value)",
  525:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  526          ]

verisol_test/0x4ee1bb7c19bc332d1b172a64a027dd8a5560ec5a-TokenMintERC20Token.inv.json:
  448              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != _totalSupply)",
  449:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  450          ]

verisol_test/0x04f33d09aae7923fcd82590b1d8fef0ce41936e1-BasedPepe.inv.json:
  360              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != balances[msg.sender])",
  361:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  362          ]

verisol_test/0x5e5948c6a1c48b5b6a19852928af3b72e974ef8d-BigBabyInu.inv.json:
  845              "VeriSol.Ensures(balances[msg.sender] != balances[to])",
  846:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  847          ]

verisol_test/0x6a137df19d3e987e3207e8c94387bece89d385f8-SACHS.inv.json:
  671              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances))",
  672:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  673          ]

verisol_test/0x6f95df342e9d336275b05b1d7a43459c26be1963-TokenMintERC20Token.inv.json:
  397              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) != _decimals)",
  398:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  399:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  400          ]

verisol_test/0x7b52118bcd20d43861cdb112150a9b0342677d3b-TokenMintERC20Token.inv.json:
  566              "VeriSol.Ensures(_balances[sender] != amount)",
  567:             "VeriSol.Ensures(amount + _balances[sender] == VeriSol.Old(_balances[sender]))"
  568          ]

verisol_test/0x07bc8d1a87c2b7caa596abce2d5bb41efc475c5c-InfernoHound.inv.json:
  857              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _totalSupply)",
  858:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  859          ]

verisol_test/0x7c5ff719a6c76fe643e9ecd0f11f146a2de05f14-GaneshaToken.inv.json:
  389              "VeriSol.Ensures(decimals != VeriSol.Old(balances[msg.sender]))",
  390:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  391          ]

verisol_test/0x7d755944d44fc8b5183b82f55889b3fbe9bebb8d-PBull.inv.json:
  19136              "VeriSol.Ensures(VeriSol.Old(UniLP) != _pairUSD)",
  19137:             "VeriSol.Ensures(_updatedBalance[msg.sender] + value == VeriSol.Old(_updatedBalance[msg.sender]))"
  19138          ]

verisol_test/0x8c867db31072f160cbfe1311d8a6cd85806dd6b4-Zeus.inv.json:
  1481              "VeriSol.Ensures(_decimals != VeriSol.Old(_balances[msg.sender]))",
  1482:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == value)"
  1483          ]

verisol_test/0x8de4644406933728ac9df5bc648d1482fb628406-TokenMintERC20Token.inv.json:
  696              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _balances[msg.sender])",
  697:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  698          ]

verisol_test/0x8ec39e54303269cfea50bb0555cf7a73fd933f73-TokenMintERC20Token.inv.json:
  1050              "VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply))",
  1051:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  1052          ]

verisol_test/0x8f12dfc7981de79a8a34070a732471f2d335eece-CryptoExcellence.inv.json:
  659              "VeriSol.Ensures(decimals != balances[to])",
  660:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  661          ]

verisol_test/0x9ab8432a7794566c27f051c087adedbf64337eea-GrandTheftArlen.inv.json:
  918              "VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_balances))",
  919:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  920          ]

verisol_test/0x09e333e720e1bd0fe82d188d6aed36d22f96d399-StandardERC20Token.inv.json:
  589              "VeriSol.Ensures(_totalSupply != VeriSol.Old(_balances[recipient]))",
  590:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  591          ]

verisol_test/0x9e0796c4146cd6ce77a9e1f77f2c3f21190a9055-TokenMintERC20Token.inv.json:
  371              "VeriSol.Ensures(VeriSol.Old(_totalSupply) != _decimals)",
  372:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  373          ]

verisol_test/0x24da31e7bb182cb2cabfef1d88db19c2ae1f5572-TokenMintERC20Token.inv.json:
  340              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != VeriSol.SumMapping(_balances))",
  341:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  342          ]

verisol_test/0x28c5d11436cf68fb0e7b21bb0c570f9ec62199a1-TokenMintERC20Token.inv.json:
  716              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != amount)",
  717:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  718          ]

verisol_test/0x32f9308c831bc74a8bcc675148e78340d812a976-BullRider.inv.json:
  586              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(uint256(_decimals)))",
  587:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  588          ]

verisol_test/0x38c97cbd6e986798207b4b29ecf01ea8977b7256-Hypano.inv.json:
  381              "VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply))",
  382:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  383          ]

verisol_test/0x43b0bc65935a59ec7d6ce15e6d3112691a8e1dd9-TokenMintERC20Token.inv.json:
  1036              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) != _decimals)",
  1037:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  1038          ]

verisol_test/0x47d920a911cb9a0ad4618698ba3fef800abc868d-TokenMintERC20Token.inv.json:
  409              "VeriSol.Ensures(VeriSol.Old(_allowances[sender][msg.sender]) != _decimals)",
  410:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  411          ]

verisol_test/0x48cd2a4947aa70251654312a2cbfa99663560cbd-CodeWithJoe.inv.json:
  687              "VeriSol.Ensures(balances[msg.sender] != msg.value)",
  688:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])"
  689          ]

verisol_test/0x51fa8077fdd878ccce56912c3cb7fb9a87d0eeaa-CodeWithJoe.inv.json:
  375              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != balances[to])",
  376:             "VeriSol.Ensures(balances[to] - tokens == VeriSol.Old(balances[to]))",
  377:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  378          ]

verisol_test/0x56df7dd5e6476af94666e856c38aefc4d4555861-DinosaurERC20Token.inv.json:
  425              "VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(_balances))",
  426:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[recipient])",
  427:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  428:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  429          ]

verisol_test/0x61d45f5475d90af0c3b3f3673beb18b43284dce7-YCCToken.inv.json:
  215              "VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances))",
  216:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  217          ]

verisol_test/0x62c23c5f75940c2275dd3cb9300289dd30992e59-TokenMintERC20Token.inv.json:
  262              "VeriSol.Ensures(_decimals != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  263:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  264          ]

verisol_test/0x62c8179b08b72acd4e745b33415aa512f2aa4097-TheHound.inv.json:
  672              "VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(uint256(decimals)))",
  673:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])",
  674:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  675          ]

verisol_test/0x72f0c5d7fb01506543c2880e1a7f808e0a81febf-DogeFather.inv.json:
  395              "VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(_totalSupply))",
  396:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  397          ]

verisol_test/0x75de9fa3e18071eab22823d6c2bcecde759250ca-BURN.inv.json:
  906              "VeriSol.Ensures(_totalSupply != msg.value)",
  907:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  908          ]

verisol_test/0x80e9dd5d9c01082f4ff1620f0d19c8b95307403e-InuClassic.inv.json:
  709              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != _balances[msg.sender])",
  710:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  711:             "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) - amount == _balances[recipient])",
  712:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  713          ]

verisol_test/0x81b3e4111b0aab36b3fd679e04e84e38931244bb-KillerShiba.inv.json:
  360              "VeriSol.Ensures(VeriSol.Old(balances[to]) != VeriSol.SumMapping(balances))",
  361:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  362          ]

verisol_test/0x85a65e23105d1b3538ceb463edfdfc3d9af179a8-SocialMoney.inv.json:
  253              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != _balances[to])",
  254:             "VeriSol.Ensures(_balances[to] - VeriSol.Old(_balances[to]) == value)"
  255          ]

verisol_test/0x97b3c9aa2ddf4d215a71090c1ee5990e2ad60fd1-SteveJobs.inv.json:
  590              "VeriSol.Ensures(msg.value != allowed[from][msg.sender])",
  591:             "VeriSol.Ensures(tokens + balances[from] == VeriSol.Old(balances[from]))",
  592:             "VeriSol.Ensures(VeriSol.Old(allowed[from][msg.sender]) - tokens == balances[from])",
  593:             "VeriSol.Ensures(allowed[from][msg.sender] + tokens == VeriSol.Old(balances[from]))",
  594:             "VeriSol.Ensures(allowed[from][msg.sender] + tokens == VeriSol.Old(allowed[from][msg.sender]))"
  595          ]

verisol_test/0x161cddfb1fb7921a01d45c147f44670bb060ace5-TokenMintERC20Token.inv.json:
  442              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != _balances[recipient])",
  443:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  444          ]

verisol_test/0x509ed91b94972adc72bf7a7b326cfa6ba6378e7e-LilShiba.inv.json:
  842              "VeriSol.Ensures(_totalSupply != amount)",
  843:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))",
  844:             "VeriSol.Ensures(amount - VeriSol.Old(_balances[recipient]) == _balances[msg.sender])",
  845:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  846          ]

verisol_test/0x514d27336b4f80419e20d2a772d14efede22f245-TokenMintERC20Token.inv.json:
  544              "VeriSol.Ensures(amount != _balances[msg.sender])",
  545:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  546          ]

verisol_test/0x547dd0dc34f446d91fb5e270cbdf4198cca30bc6-SocialMoney.inv.json:
  406              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) <= VeriSol.SumMapping(_balances))",
  407:             "VeriSol.Ensures(_balances[to] - VeriSol.Old(_balances[to]) == value)"
  408          ]

verisol_test/0x617b0e7d37b5cd55ad584c7e806a71c64ecc2a28-TokenMintERC20Token.inv.json:
  424              "VeriSol.Ensures(_totalSupply != VeriSol.Old(_balances[recipient]))",
  425:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))",
  426:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  427          ]

verisol_test/0x642fab3778de79df3e0f9e21694c7d90e07f6ea3-AKAMARU.inv.json:
  961              "VeriSol.Ensures(basePercent != VeriSol.Old(_balances[to]))",
  962:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - value == _balances[msg.sender])"
  963          ]

verisol_test/0x669b2360e3e33d0b4d60cbe05a5cdc0c0f2e8346-SAFEPEPPA.inv.json:
  1949              "VeriSol.Ensures(_balances[to] != VeriSol.Old(_burnStopAmount))",
  1950:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == value)"
  1951          ]

verisol_test/0x766d4c9c1c7316e97968a36b7b01bf7fcda7feb6-KogiInuToken.inv.json:
  487              "VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(_totalSupply))",
  488:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  489          ]

verisol_test/0x911f5e6b29ae4f9c8f1c3d179b9b249bba6d8262-TokenMintERC20Token.inv.json:
  549              "VeriSol.Ensures(_totalSupply != amount)",
  550:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  551          ]

verisol_test/0x968afac04e82e186f2135ce689cd775084016c35-TokenMintERC20Token.inv.json:
  387              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(_balances[recipient]))",
  388:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])",
  389:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  390          ]

verisol_test/0x3130dd4efcfd51166934039cb5747707a55f3a5e-GuideAmbassador.inv.json:
  365              "VeriSol.Ensures(_totalSupply != VeriSol.Old(balances[msg.sender]))",
  366:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])",
  367:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  368          ]

verisol_test/0x3301ee63fb29f863f2333bd4466acb46cd8323e6-AKITAERC20Token.inv.json:
  412              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) <= VeriSol.SumMapping(_balances))",
  413:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - amount == _balances[msg.sender])"
  414          ]

verisol_test/0x3622d034fbf3baec7060c7cb484a121389684986-RyukyuInuERC20Token.inv.json:
  550              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) != _totalSupply)",
  551:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  552          ]

verisol_test/0x4804fb55e75bd1c32ab06cd053c5510c1b80fd26-SocialMoney.inv.json:
  425              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != _totalSupply)",
  426:             "VeriSol.Ensures(VeriSol.Old(_allowed[from][msg.sender]) - value == _allowed[from][msg.sender])",
  427:             "VeriSol.Ensures(VeriSol.Old(_balances[from]) - value == _balances[from])"
  428          ]

verisol_test/0x5672f74741549428e38a440fd73d90fc8364e863-TokenMintERC20Token.inv.json:
  606              "VeriSol.Ensures(Account == VeriSol.Old(Account))",
  607:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  608          ]

verisol_test/0x8037fbdb3a8b4befdd40fcd75e899b2aba5bf5a3-TokenMintERC20Token.inv.json:
  399              "VeriSol.Ensures(_decimals <= VeriSol.Old(_totalSupply))",
  400:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))",
  401:             "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) + amount == _balances[recipient])"
  402          ]

verisol_test/0x9682e720ddf3b8c667966a72bb62649c58a53d5e-DOGHOUSE.inv.json:
  1533              "VeriSol.Ensures(basePercent != msg.value)",
  1534:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))"
  1535          ]

verisol_test/0x56366ce135cc5f636365f11e4e3450ef03241c44-Bone.inv.json:
  502              "VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(balances[msg.sender]))",
  503:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  504          ]

verisol_test/0x70665f330191abababc772f5e51ba1ecf61672ef-TokenMintERC20Token.inv.json:
  690              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(_totalSupply))",
  691:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  692          ]

verisol_test/0x78689fd6ecd9c168b2ba69ff022ff70302f0bba7-BLOCKYDOGE.inv.json:
  394              "VeriSol.Ensures(msg.value != balances[msg.sender])",
  395:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])",
  396:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  397          ]

verisol_test/0x299209fa44d48863c84125bbae12676ed6ce8e97-TokenMintERC20Token.inv.json:
  404              "VeriSol.Ensures(_decimals != _balances[recipient])",
  405:             "VeriSol.Ensures(_balances[recipient] - VeriSol.Old(_balances[recipient]) == amount)"
  406          ]

verisol_test/0x378385c2f2ab9052e38d9cb4025ebf696c17b291-ECTONETWORK.inv.json:
  359              "VeriSol.Ensures(_totalSupply != msg.value)",
  360:             "VeriSol.Ensures(balances[to] - VeriSol.Old(balances[to]) == tokens)"
  361          ]

verisol_test/0x380724fa326ef4a616798e67ac042b2b647decd3-SpartanGlobalCoin.inv.json:
  351              "VeriSol.Ensures(decimals != tokens)",
  352:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])"
  353          ]

verisol_test/0x3781731acd887b14d7f7f261f3aada7f6405868a-Arcanite.inv.json:
  340              "VeriSol.Ensures(_totalSupply != balances[msg.sender])",
  341:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  342          ]

verisol_test/0x6466165ef085c4b5bc9c978397b128a85d12c184-TokenMintERC20Token.inv.json:
  336              "VeriSol.Ensures(_balances[msg.sender] != _decimals)",
  337:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(VeriSol.SumMapping(_balances)))",
  338:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_balances[msg.sender]))",
  339:             "VeriSol.Ensures(_balances[msg.sender] + value == VeriSol.Old(_totalSupply))"
  340          ]

  561              "VeriSol.Ensures(_balances[msg.sender] != _decimals)",
  562:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  563          ]

verisol_test/0x6767615a97a8204298bbac44c57ef1a615eed244-CribnbERC20.inv.json:
  372              "VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances))",
  373:             "VeriSol.Ensures(VeriSol.Old(balances[from]) - tokens == balances[from])",
  374:             "VeriSol.Ensures(tokens + allowed[from][msg.sender] == VeriSol.Old(allowed[from][msg.sender]))"
  375          ]

verisol_test/0x7302429c53c54d15328e3e393d52d005e9759355-XINU.inv.json:
  400              "VeriSol.Ensures(_balances[msg.sender] >= msg.value)",
  401:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  402          ]

verisol_test/0x7631127e358517e3b15903bbcb0f50a45a4379db-SING.inv.json:
  358              "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) != VeriSol.SumMapping(balances))",
  359:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  360          ]

verisol_test/0x62406995cafd18f57e7375e8e0060725acebce58-FirulaisWalletToken.inv.json:
  614              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != msg.value)",
  615:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))",
  616:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  617          ]

verisol_test/0x78132543d8e20d2417d8a07d9ae199d458a0d581-TokenMintERC20Token.inv.json:
  730              "VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)))",
  731:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  732          ]

verisol_test/0x836775359fd7b19409f2914719c67e4db7073eab-TokenMintERC20Token.inv.json:
  452              "VeriSol.Ensures(_decimals != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  453:             "VeriSol.Ensures(VeriSol.Old(_allowances[msg.sender][spender]) + addedValue == _allowances[msg.sender][spender])"
  454          ]

  633              "VeriSol.Ensures(_decimals != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  634:             "VeriSol.Ensures(VeriSol.Old(_allowances[msg.sender][spender]) - _allowances[msg.sender][spender] == subtractedValue)"
  635          ]

verisol_test/0x846132977b441bcbaeeefb79e056f7c5be8fcdf3-TokenMintERC20Token.inv.json:
  392              "VeriSol.Ensures(_decimals != amount)",
  393:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  394          ]

verisol_test/0x4333993025af6475b86e18e3ef8b371bb5966ec8-TokenMintERC20Token.inv.json:
  358              "VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != _balances[msg.sender])",
  359:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))",
  360:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  361          ]

verisol_test/0x56779592815d1d9298d5c88fc64413b1eaaf00dc-CodeWithJoe.inv.json:
  344              "VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(_totalSupply))",
  345:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])"
  346          ]

verisol_test/0xa1a7a1c19e6cc4c79ea5f4b344181cf1be07e6d6-TokenMintERC20Token.inv.json:
  570              "VeriSol.Ensures(_balances[recipient] <= amount)",
  571:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  572          ]

verisol_test/0xa25c780132be018a4064f0aa62ff54a32687ae14-Bone.inv.json:
  356              "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) <= VeriSol.SumMapping(balances))",
  357:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - balances[msg.sender] == tokens)"
  358          ]

verisol_test/0xad27a16d8835d880d4c8c5c17a4b6fd8ad1811a7-SocialMoney.inv.json:
  252              "VeriSol.Ensures(_balances[msg.sender] != value)",
  253:             "VeriSol.Ensures(value + VeriSol.Old(_balances[to]) == _balances[to])"
  254          ]

verisol_test/0xb6a3fb9a636f6f3b22c06c8ba62b63d7d499fa15-TokenMintERC20Token.inv.json:
  416              "VeriSol.Ensures(_balances[recipient] != msg.value)",
  417:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  418          ]

verisol_test/0xb77ffbb00f4c529747bab93bdeb3dce49b021e76-SafeDawg.inv.json:
  514              "VeriSol.Ensures(balances[msg.sender] != _totalSupply)",
  515:             "VeriSol.Ensures(VeriSol.Old(balances[to]) + tokens == balances[to])"
  516          ]

verisol_test/0xb934c43268adaedee892c4e8d3d56b010498e80c-clashPay.inv.json:
  1181              "VeriSol.Ensures(_to != Tokenfarm)",
  1182:             "VeriSol.Ensures(_value + balanceOf[msg.sender] == VeriSol.Old(balanceOf[msg.sender]))"
  1183          ]

verisol_test/0xb874921bfc23e4800a72d0108458cb14ccd12601-PreciousMetalCapital.inv.json:
  590              "VeriSol.Ensures(VeriSol.Old(_balances[sender]) != _allowances[sender][msg.sender])",
  591:             "VeriSol.Ensures(_allowances[sender][msg.sender] + amount == VeriSol.Old(_allowances[sender][msg.sender]))"
  592          ]

verisol_test/0xb2923909b5d8bbe01505121f15a4503b6617dae7-WrappedHeC.inv.json:
  221              "VeriSol.Ensures(_totalSupply != balances[to])",
  222:             "VeriSol.Ensures(balances[to] - VeriSol.Old(balances[to]) == tokens)"
  223          ]

verisol_test/0xb7131835d3fc64bcb1976733e28af8364d328f5c-DOGKINGERC20Token.inv.json:
  410              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  411:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  412          ]

verisol_test/0xc5ba8e0afbbc9eedcd9f8c780e36369b0769ee52-DRAKON.inv.json:
  418              "VeriSol.Ensures(msg.value != _decimals)",
  419:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  420          ]

verisol_test/0xc8b98f0030ef771b18f2bcb77964111f2889ebd3-FuckSellers.inv.json:
  9689              "VeriSol.Ensures(_updatedBalance[LastBuyer] != VeriSol.Old(_updatedBalance[NextVault]))",
  9690:             "VeriSol.Ensures(_updatedBalance[VeriSol.Old(LastBuyer)] - value == VeriSol.Old(_updatedBalance[LastBuyer]))",
  9691:             "VeriSol.Ensures(_updatedBalance[LastBuyer] - value == VeriSol.Old(_updatedBalance[LastBuyer]))",
  9692:             "VeriSol.Ensures(value + VeriSol.Old(_updatedBalance[to]) == _updatedBalance[to])",
  9693:             "VeriSol.Ensures(_updatedBalance[VeriSol.Old(LastBuyer)] - value == VeriSol.Old(RestValue))",
  9694:             "VeriSol.Ensures(_updatedBalance[LastBuyer] - value == VeriSol.Old(RestValue))",
  9695:             "VeriSol.Ensures(_updatedBalance[msg.sender] + value == VeriSol.Old(_updatedBalance[msg.sender]))",
  9696:             "VeriSol.Ensures(_updatedBalance[VeriSol.Old(LastBuyer)] - value == VeriSol.Old(_updatedBalance[VeriSol.Old(LastBuyer)]))",
  9697:             "VeriSol.Ensures(_updatedBalance[LastBuyer] - value == VeriSol.Old(_updatedBalance[VeriSol.Old(LastBuyer)]))"
  9698          ]

verisol_test/0xc45efe8b705c97e9d49612443ccb10aec52a2543-ProofOfRyoshi.inv.json:
  430              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != _balances[recipient])",
  431:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == amount)"
  432          ]

verisol_test/0xc8705424948e97e6db98022ba81bca5164660c82-KogiInuToken.inv.json:
  391              "VeriSol.Ensures(decimals != VeriSol.Old(balances[msg.sender]))",
  392:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) - tokens == balances[msg.sender])"
  393          ]

verisol_test/0xcaec28836b84f8b5c533983799fd78412fb4395a-TokenMintERC20Token.inv.json:
  429              "VeriSol.Ensures(_totalSupply != _balances[msg.sender])",
  430:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  431          ]

verisol_test/0xce5860c82d49037efdfe300c7488263298a93501-RickRoll.inv.json:
  370              "VeriSol.Ensures(decimals != balances[to])",
  371:             "VeriSol.Ensures(balances[to] - tokens == VeriSol.Old(balances[to]))",
  372:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  373          ]

verisol_test/0xcfa6ab49f69800b877070f231f22496249990cee-Brahma.inv.json:
  813              "VeriSol.Ensures(VeriSol.SumMapping(balances) != tokens)",
  814:             "VeriSol.Ensures(tokens + VeriSol.Old(balances[to]) == balances[to])"
  815          ]

verisol_test/0xcfa1279b6a3860493f64cce1344f4e9c825113e4-GOCP.inv.json:
  191              "VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(balances[msg.sender]))",
  192:             "VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) + _value == balances[msg.sender])"
  193          ]

verisol_test/0xd50e079db8d18d594144108077f945218999acb0-TokenMintERC20Token.inv.json:
  448              "VeriSol.Ensures(VeriSol.Old(_balances[recipient]) <= _balances[msg.sender])",
  449:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  450          ]

verisol_test/0xd83ea66d2ec74617734e82a39e7fe90496599204-SocialMoney.inv.json:
  371              "VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(_balances[msg.sender]))",
  372:             "VeriSol.Ensures(_balances[to] - value == VeriSol.Old(_balances[to]))"
  373          ]

verisol_test/0xda6f3e151596cdc0c504e14932496ab8b2050895-FlowerToken.inv.json:
  359              "VeriSol.Ensures(tokens != balances[msg.sender])",
  360:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  361          ]

verisol_test/0xdeb14c17e9c8ed4c64a2194e7758a072af69ef89-TokenMintERC20Token.inv.json:
  614              "VeriSol.Ensures(_balances[msg.sender] != VeriSol.Old(VeriSol.SumMapping(_balances)))",
  615:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  616          ]

verisol_test/0xe4f6d46c244bb7cf3e218cdfb5c35cf9a4d9c920-Donkey.inv.json:
  376              "VeriSol.Ensures(_totalSupply != VeriSol.Old(VeriSol.SumMapping(balances)))",
  377:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  378          ]

verisol_test/0xe09fb60e8d6e7e1cebbe821bd5c3fc67a40f86bf-PikachuToken.inv.json:
  599              "VeriSol.Ensures(VeriSol.Old(_totalSupply) != _balances[recipient])",
  600:             "VeriSol.Ensures(amount + _balances[msg.sender] == VeriSol.Old(_balances[msg.sender]))"
  601          ]

verisol_test/0xe774959acd78a33ab7730b44a9455fb99d5a7ea8-MXSamurai.inv.json:
  527              "VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != _totalSupply)",
  528:             "VeriSol.Ensures(tokens + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  529          ]

verisol_test/0xea75671ab1d5c71b29399c0c4eccd5a9dbe41370-TokenMintERC20Token.inv.json:
  348              "VeriSol.Ensures(_decimals != amount)",
  349:             "VeriSol.Ensures(amount + VeriSol.Old(_balances[recipient]) == _balances[recipient])"
  350          ]

verisol_test/0xeb2fce02460b095f7b084081c4799db0fb0b8a84-Cheese2.inv.json:
  877              "VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)))",
  878:             "VeriSol.Ensures(_balances[msg.sender] + amount == VeriSol.Old(_balances[msg.sender]))"
  879          ]

verisol_test/0xec4a1c7a4e9fdc7cc621b548a931c92bc08a679a-Goji.inv.json:
  350              "VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(_totalSupply))",
  351:             "VeriSol.Ensures(balances[to] - tokens == VeriSol.Old(balances[to]))"
  352          ]

verisol_test/0xeef7eaa73cab2f07f8ecee246f479a76139e236d-MyloToken.inv.json:
  367              "VeriSol.Ensures(_totalSupply != balances[to])",
  368:             "VeriSol.Ensures(balances[msg.sender] + tokens == VeriSol.Old(balances[msg.sender]))"
  369          ]

verisol_test/0xf4c3a87ce0e92dadd82b494bcefd0cdeca9b03dd-SAFEKONG.inv.json:
  915              "VeriSol.Ensures(_decimals != VeriSol.Old(_balances[msg.sender]))",
  916:             "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == value)"
  917          ]

verisol_test/0xf8ccad1b25a54ce12f1b1ee56ef0f2a930d3e969-Finder.inv.json:
  475              "VeriSol.Ensures(decimals != VeriSol.Old(totalSupply_))",
  476:             "VeriSol.Ensures(_value + balances[msg.sender] == VeriSol.Old(balances[msg.sender]))"
  477          ]

verisol_test/0xf61ae54b74a37be4fc11e9f1a35021848d996afc-EmaxClassic.inv.json:
  379              "VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) >= _balances[recipient])",
  380:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  381          ]

verisol_test/0xff354e95d1120ae2d9e5db4c1cd18da7d976f1b7-TokenMintERC20Token.inv.json:
  422              "VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= VeriSol.SumMapping(_balances))",
  423:             "VeriSol.Ensures(_balances[recipient] - amount == VeriSol.Old(_balances[recipient]))"
  424          ]
