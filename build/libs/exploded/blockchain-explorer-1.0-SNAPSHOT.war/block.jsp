<%--
  Created by IntelliJ IDEA.
  User: imqsl
  Date: 2017-10-26
  Time: 17:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags-->
    <meta name="description" content="以太坊区块链浏览器">
    <meta name="author" content="imqsl">
    <meta name="keywords"
          content="以太坊, 浏览器, 区块链, etherchain, 加密货币, 比特币">
    <meta name="theme-color" content="#18bc9c">
    <link rel="icon" href="//etherchain.org/images/glyphicons-51-link.png">
    <title>区块 - 以太坊区块链浏览器</title>
    <!-- Bootstrap core CSS-->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.datatables.net/r/bs/dt-1.10.9/datatables.min.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/styles/default.min.css">
    <style>
        body {
            padding-top: 50px;
            padding-bottom: 20px;
        }</style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.3/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/2.0.7/bignumber.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/numeral.js/1.4.5/numeral.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script>
    <script src="dateFormat.js"></script>

</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" data-toggle="collapse" data-target="#navbar" aria-expanded="false"
                    aria-controls="navbar" class="navbar-toggle collapsed">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="/" title="SCU嵌入式实验室" class="navbar-brand">
                <span class="glyphicon glyphicon-link"></span>川大嵌入式实验室</a></div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown"><a href="#" data-toggle="dropdown" role="button" aria-haspopup="true"
                                        aria-expanded="false" class="dropdown-toggle"><span
                        class="glyphicon glyphicon-eye-open"></span> 区块链<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="blocks.jsp"><span class="glyphicon glyphicon-book"></span> 区块</a></li>
                        <li><a href="txs.jsp"><span class="glyphicon glyphicon-transfer"></span> 交易</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a href="#" data-toggle="dropdown" role="button" aria-haspopup="true"
                                        aria-expanded="false" class="dropdown-toggle"><span
                        class="glyphicon glyphicon-list-alt"></span> 账户<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="acounts.jsp">账户</a></li>
                    </ul>
                </li>

                <li class="dropdown"><a href="#" data-toggle="dropdown" role="button" aria-haspopup="true"
                                        aria-expanded="false" class="dropdown-toggle">
                    <div class="span glyphicon glyphicon-wrench"></div>
                    工具<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="https://ens.etherchain.org/" target="_blank"><span
                                class="glyphicon glyphicon-globe"></span> Ethereum Name Service</a></li>
                        <li><a href="https://www.ethernodes.org/" target="_blank">Nodes Explorer</a></li>
                        <li><a href="https://github.com/gobitfly/etherchain-light" target="_blank">Etherchain Light</a>
                        </li>
                        <li><a href="https://github.com/gobitfly/erc20-explorer" target="_blank">ERC20 Token
                            explorer</a></li>
                        <li><a href="/documentation/api/">API</a></li>
                        <li><a href="/verify/signature">Verify Ethereum signatures</a></li>
                    </ul>
                </li>
            </ul>
            <form action="/search" method="POST" class="navbar-form navbar-right">
                <div class="form-group"><input type="text" placeholder="ENS, Tx Hash, Address or Block number"
                                               id="search" name="search" class="form-control input-sm"></div>
                <button type="submit" style="margin-left: 2px" class="btn btn-success">
                    <span class="glyphicon glyphicon-search"></span></button>
            </form>
        </div>
    </div>
</nav>
<div id="block" class="container">
    <div class="row">
        <div class="col-md-2">
            <div class="nav">
                <ul class="pager">
                    <li><a aria-label="Previous" id="previous">Previous</a></li>
                </ul>
            </div>
        </div>
        <div class="col-md-8"><h1 id="blocknumber">区块号: </h1></div>
        <div class="col-md-1">
            <div class="nav">
                <ul class="pager">
                    <li><a aria-label="Next" id="next">Next</a></li>
                </ul>
            </div>
        </div>
    </div>
    <table class="table table-condensed table-responsive">
        <tr>
            <th>Hash:</th>
            <td ><span id="hash"></span></td>
        </tr>
        <tr>
            <th>Difficulty:</th>
            <td><span id="difficulty"></span></td>
        </tr>
        <tr>
            <th>Miner:</th>
            <td><a id="miner"></a></td>
        </tr>
        <tr>
            <th>Gas Limit:</th>
            <td><span id="gaslimit"></span></td>
        </tr>
        <tr>
            <th>Gas Usage:</th>
            <td><span id="gasusg"></span></td>
        </tr>
        <tr></tr>

            <th>Time:</th>
            <td><span id="time"></span></td>
        </tr>
        <tr>
            <th>Uncle Hash:</th>
            <td><span id="unclehash"></span></td>
        </tr>
        <tr>
            <th>Root:</th>
            <td><span id="root"></span></td>
        </tr>
        <tr>
            <th>Tx Hash:</th>
            <td><span id="txhash"></span></td>
        </tr>
        <tr>
            <th>Size:</th>
            <td><span id="size"></span></td>
        </tr>
        <tr>
            <th>Extra:</th>
            <td><span id="extra"></span></td>
        </tr>
        <tr>
            <th>Nonce:</th>
            <td><span id="nonce"></span></td>
        </tr>
        <tr>
            <th>Reward:</th>
            <td><span id="reward"></span></td>
        </tr>
    </table>
    <h2>Transactions</h2>
    <table class="table table-condensed table-responsive">
        <tr>
            <th>Hash</th>
            <th>From</th>
            <th>To</th>
            <th>Amount</th>
            <th>Fee</th>
        </tr>
        <tr>
            <td><a href="/tx/0x0c5241dca163bf1e0872ad16a4d7e11c44206911c7a31b5873ca847131b07aee">0x0c5241dc...</a></td>
            <td><a href="/account/0x22b84d5ffea8b801c0422afe752377a64aa738c2">0x22B84d5FFeA8b...</a></td>
            <td><a href="/account/0xa5d9fc57d8c21efcbce1d55abdd4e225e5ddfbd2">0xa5d9fC57d8c21...</a></td>
            <td>0.1 Ether ($29.86)</td>
            <td>0.000168 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x2fd94650538924f152eb4ffe5d5341705b64f8eb3360cbc624df81a00eec122d">0x2fd94650...</a></td>
            <td><a href="/account/0x08609afe1918f72fad07cb643a28c6503d608dd6">0x08609afE1918F...</a></td>
            <td><a href="/account/0x286343d3c380150d39c1339531b3de6fca66fa52">0x286343d3c3801...</a></td>
            <td>0.001 Ether ($0.30)</td>
            <td>0.000441 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x3006482e78e9792341c10c85211c9282f04f1897d3fc45db8d2bb4b58128602e">0x3006482e...</a></td>
            <td><a href="/account/0x0d692c3dff6238a811b37c9d6abf7571c4c1083c">0x0D692C3Dff623...</a></td>
            <td><a href="/account/0xf90c9ac616ecfefb3860aaa5bc33caf9bc606441">0xf90c9aC616ECf...</a></td>
            <td>0.04517934000000001 Ether ($13.49)</td>
            <td>0.00016864 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x353b28dba59bd982776bc54c08a46f72af1dba05a64ad196ef913635a9fc2e83">0x353b28db...</a></td>
            <td><a href="/account/0xf87b4a80d504497576249ca837af9f284a319647">0xf87b4a80d5044...</a></td>
            <td><a href="/account/0xcb97e65f07da24d46bcdd078ebebd7c6e6e3d750">0xcB97e65F07DA2...</a></td>
            <td>0 Ether ($0.00)</td>
            <td>0.001057775 Ether ($0.32)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x3e55b3b97e7a4472b7560e00942bd7a8e8e527146967d5626052f0984f06fad8">0x3e55b3b9...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x0de7496bbfd218aee03b202655e5338465f6467e">0x0De7496BBFD21...</a></td>
            <td>4.37356187 Ether ($1,305.95)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x4226159c46a4bd0108ee76f798d69d14d6c99f6501907b8e42b1e823fe96d901">0x4226159c...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x51075964fa80add415e04f2ff4f5c97d07debd43">0x51075964fA80A...</a></td>
            <td>0.08817148 Ether ($26.33)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x43678a5a60bdd437581cb3c4795e537df9b6d193fdde92300a0a36151f62accd">0x43678a5a...</a></td>
            <td><a href="/account/0xd52bad882d3d0f9b2b1b4760527515713df93efb">0xd52BAd882d3d0...</a></td>
            <td><a href="/account/0x1b1c01611c3051b92cb987997fb8fbf1036690a9">0x1b1c01611C305...</a></td>
            <td>0.015 Ether ($4.48)</td>
            <td>0.00063 Ether ($0.19)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x43ea80269c001b0fba3338afdef37d6287d9666e3638f4fef74036da4e239dbb">0x43ea8026...</a></td>
            <td><a href="/account/0x0bf315087c0a9cde70df5d41c40e03b0d5a3b0e6">0x0BF315087C0A9...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>741.7765994066085 Ether ($221,494.49)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x49bd8150a76c10c42c69a49f2ea71beebcbbacaba4584dec91a31a9e18765762">0x49bd8150...</a></td>
            <td><a href="/account/0x1b7a9955353d0ddb984eecf69e8928010a816dc3">0x1B7a9955353D0...</a></td>
            <td><a href="/account/0x3b609ed5cb554aad191c7bfe5d8a09c279b32cb5">0x3B609ed5cb554...</a></td>
            <td>0.01 Ether ($2.99)</td>
            <td>0.000168 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x4a4f4e4a2a6c3afd37cdc34ec7991e2efcddba73309106541943d935ac23f664">0x4a4f4e4a...</a></td>
            <td><a href="/account/0x8e1f56859006d2c936efc423596210f18c5a00da">0x8e1F56859006D...</a></td>
            <td><a href="/account/0xb4dd0c7f4a1cadfb9408d260fcafc009732b5650">0xb4dD0c7F4a1cA...</a></td>
            <td>0.035 Ether ($10.45)</td>
            <td>0.00011694375 Ether ($0.03)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x4da244183cea6fd4cc3f9fa3e9627ab3695c79a98e6a40504d96c98f9ec715ec">0x4da24418...</a></td>
            <td><a href="/account/0x0126017635277bd7bd3b75655e737402309b419d">0x0126017635277...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.04873185 Ether ($14.55)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x588cbf2395cccd53c4ca8b82e7f7931d7df1f2e83fb1a07f61e119984909e02f">0x588cbf23...</a></td>
            <td><a href="/account/0x46da9a68853c5f51b33cb507d14378f6028e095f">0x46Da9a68853C5...</a></td>
            <td><a href="/account/0xa0f4c87a59890a28931ba41c6847d27b34f942a6">0xa0f4c87a59890...</a></td>
            <td>1.000876 Ether ($298.86)</td>
            <td>0.000609 Ether ($0.18)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x58a7b7a6faac41fc0b3a4b8bba194221eb7ac03a7482d0228bb5b73d32583987">0x58a7b7a6...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x7a515aaf7680e51b3c4ceb2dc89179c49c25eb48">0x7a515aaF7680E...</a></td>
            <td>0.29247928 Ether ($87.33)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x598b8b591083bc8a3c6b26596422d07e20db5506af62e16af2f37634c60d37cc">0x598b8b59...</a></td>
            <td><a href="/account/0xf607e6e4184a89952783a30362e578dae564884f">0xF607E6E4184A8...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.0788925 Ether ($23.56)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x5ae0a92cbb5648a0e0781aa5dbd8fa21b4f012f9a01d4b5e7ec21f7d2efcb7cf">0x5ae0a92c...</a></td>
            <td><a href="/account/0xfae6b6fc907c6362999429f9ca47a5f251c0bc80">0xFaE6B6fc907c6...</a></td>
            <td><a href="/account/0xcb97e65f07da24d46bcdd078ebebd7c6e6e3d750">0xcB97e65F07DA2...</a></td>
            <td>0 Ether ($0.00)</td>
            <td>0.001057775 Ether ($0.32)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x5fc88f9e2a9239eeb772a2b64f5e1afa287ade1538d7bb1d4f7e635604360dad">0x5fc88f9e...</a></td>
            <td><a href="/account/0x33d2eb9a58f175ba25ca74f259ae7dc27af6c426">0x33d2eb9a58f17...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.00096 Ether ($0.29)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x658d2c9efff6c63b482a0672961fbd19e6bad6c4d037631742e926cc07c21348">0x658d2c9e...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x9f73e2edc29c0c053505a42720774c010867939f">0x9f73E2Edc29c0...</a></td>
            <td>1 Ether ($298.60)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x6ca1a18eb29f27cfbf0be4ca4b549377ac009811bd244288ad5dd3955ffaeee0">0x6ca1a18e...</a></td>
            <td><a href="/account/0x2b5634c42055806a59e9107ed44d43c426e58258">0x2B5634C420558...</a></td>
            <td><a href="/account/0x7e17b5f9b6d68930752d5a75c9851054a192be7a">0x7E17B5f9B6d68...</a></td>
            <td>99.9995 Ether ($29,859.85)</td>
            <td>0.000168 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x72fa0adfc40117e3dc82f778a4dbd5fa99daa674ed4935a30f2de064da1b35cb">0x72fa0adf...</a></td>
            <td><a href="/account/0xad394df6138d22fe48b1cd9e4e1df3ac2f89a3f3">0xad394dF6138d2...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.00096 Ether ($0.29)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x7a9f4a07728e18f5fa4281c41497af23ac2245bbbcd73c0040db1cbd3800c630">0x7a9f4a07...</a></td>
            <td><a href="/account/0xea674fdde714fd979de3edf0f56aa9716b898ec8">ethermine</a></td>
            <td><a href="/account/0x975aa30729c6b85f3f4774ecd12a05584b7d725e">0x975aa30729C6b...</a></td>
            <td>0.049604605072123304 Ether ($14.81)</td>
            <td>0.000168 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x82cc59198c3276fb6b3baf45164f3645324fdb5fef5e78dafbcb41cefa30d669">0x82cc5919...</a></td>
            <td><a href="/account/0x38c7518ae9e9d8db37021ac13eafff6f505a2ba9">0x38c7518aE9e9D...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.09958 Ether ($29.73)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x9060f054002f533bf7c380e35eed8d95adfcaac9fa6812b6e969c301c094b5b4">0x9060f054...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x83045a5ca3a74805b5cbf4ee5d3429d6094ad3f3">0x83045a5Ca3A74...</a></td>
            <td>0.51601154 Ether ($154.08)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x9289d25d981b2399e92b324b152ac57abbf0a43c3505249583f468c10aabccfa">0x9289d25d...</a></td>
            <td><a href="/account/0x2a81714fffbc0ec8dd3c119fac2928687b4f3f99">0x2a81714fFFbc0...</a></td>
            <td><a href="/account/0x0d22ab5807594c6bf342cbd9d3ae4bedb07f0472">0x0D22ab5807594...</a></td>
            <td>0.015359832718 Ether ($4.59)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x959d48f9dd657d9ecb1787272fbe49f094ae09e7c59f7a181ceb8983a259fd7f">0x959d48f9...</a></td>
            <td><a href="/account/0xbbffa7f79a49aca1e01afc90d8c060430ba3b49d">0xbBffA7f79a49a...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.05188542 Ether ($15.49)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x9aed95a3cd64f5f73221ed224f97432409cb8b764dfd4771cc2e19b676cd1928">0x9aed95a3...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x1d073dc486c8f7e8be2386a1e346ca160e84083a">0x1D073Dc486C8f...</a></td>
            <td>3.03105884 Ether ($905.07)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0x9bf21c46654b54b33f8b84af967816bee25c2f389c38b7d57a994b97a82d9193">0x9bf21c46...</a></td>
            <td><a href="/account/0x26cb43bb84e31951de8afa25e7d880e5f42606e6">0x26cb43BB84E31...</a></td>
            <td><a href="/account/0x0161e93f774be2e26451153fe85d99fa1e088f60">0x0161E93F774BE...</a></td>
            <td>1 Ether ($298.60)</td>
            <td>0.000441 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xa7024e9534a4f3cfaf86505518091dd2b1c91c4869152644a450f1acc0ec5776">0xa7024e95...</a></td>
            <td><a href="/account/0xea674fdde714fd979de3edf0f56aa9716b898ec8">ethermine</a></td>
            <td><a href="/account/0x1b088c4fb01813ed70d63734712a5809026097df">0x1B088c4fb0181...</a></td>
            <td>1.000025426459202 Ether ($298.61)</td>
            <td>0.000168 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xb651336bb86cd73885f9c99e0fefcc2db489eaee081e59b877df6ba1b4a417a0">0xb651336b...</a></td>
            <td><a href="/account/0x52bc44d5378309ee2abf1539bf71de1b7d7be3b5">nanopool</a></td>
            <td><a href="/account/0x19c1a308cc07fb83751e3c9c281ce19d8fdce26b">0x19c1A308cC07F...</a></td>
            <td>0.10124295415985899 Ether ($30.23)</td>
            <td>0.000084 Ether ($0.03)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xb9ab4162d41a94fa4308ac9d37ddbf74634611f864ef74b1c947af5daaa59223">0xb9ab4162...</a></td>
            <td><a href="/account/0x877ab074c98c11eacb4217e22f1e0027d065587d">0x877ab074c98c1...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.055174345394936 Ether ($16.48)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xbf9422c9f5a5d46e49b22963160ba1a89553fe0d8cb68151a79f35e41f7a1c7c">0xbf9422c9...</a></td>
            <td><a href="/account/0xa81f71d4d0506a635e9e29c6e6c71ca9fdebf4af">0xA81F71d4d0506...</a></td>
            <td><a href="/account/0xf90c9ac616ecfefb3860aaa5bc33caf9bc606441">0xf90c9aC616ECf...</a></td>
            <td>1.879 Ether ($561.07)</td>
            <td>0.00016864 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xc4bfe778b523b444d79c69cbb07bc351f509cb32453a3b729127e1e0d7244a95">0xc4bfe778...</a></td>
            <td><a href="/account/0x20ef9d4636f74685b4117de9b41282cec1fab97e">0x20EF9d4636f74...</a></td>
            <td><a href="/account/0x8d12a197cb00d4747a1fe03395095ce2a5cc6819">0x8d12A197cB00D...</a></td>
            <td>0 Ether ($0.00)</td>
            <td>0.0001516 Ether ($0.05)</td>
        </tr>
        <tr>
            <td><span title="Transaction invoked by contract" class="glyphicon glyphicon-arrow-right">&nbsp;</span><a
                    href="/tx/0xaf22011ebd3b2e5ce70ca11d30a293cfee687859e37ca45c088fe01eb0a95b79">0xaf2201...</a></td>
            <td><a href="/account/0x8d12a197cb00d4747a1fe03395095ce2a5cc6819">0x8d12A197cB00D...</a></td>
            <td><a href="/account/0x20ef9d4636f74685b4117de9b41282cec1fab97e">0x20EF9d4636f74...</a></td>
            <td>0.08 Ether ($23.89)</td>
            <td>0 Ether ($0.00)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xca0bfe34322492968e92caa74140365a40318afdb004dc3eda09c3fdcf06b77a">0xca0bfe34...</a></td>
            <td><a href="/account/0x52bc44d5378309ee2abf1539bf71de1b7d7be3b5">nanopool</a></td>
            <td><a href="/account/0x63aef5f4edb51de5643868ca3b0ac2ded9e0b338">0x63aEf5F4edb51...</a></td>
            <td>0.0507559518086342 Ether ($15.16)</td>
            <td>0.000084204 Ether ($0.03)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xcd0df84bff160b9734fe048be5dd6ec182e5fbd795623e2428e3c952254d1ccc">0xcd0df84b...</a></td>
            <td><a href="/account/0x826973fc08436ac0b8302a90e614fcc159f1d494">0x826973FC08436...</a></td>
            <td><a href="/account/0x5666663663dcaa4fe745d166bfa9b7e2f2fd6435">0x5666663663dCA...</a></td>
            <td>20 Ether ($5,972.00)</td>
            <td>0.000399761639424 Ether ($0.12)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xd965d35b182647d3b1994658ed7fcf98cf2ee5c901c95b85237554955ff944ec">0xd965d35b...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x96ce1cad68206538e722579721bf12000dbcca03">0x96Ce1CaD68206...</a></td>
            <td>57.495 Ether ($17,168.01)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xe58056aec05c97aa9a52df3504dfa49c43446f30858367b3a26156670c160d5f">0xe58056ae...</a></td>
            <td><a href="/account/0x7926b7997ba57444cef48723654522390632dbf2">0x7926b7997BA57...</a></td>
            <td><a href="/account/0x5aa2ea4a743ca50c076a813e2aac1e13b54cc8db">0x5aa2eA4a743cA...</a></td>
            <td>1.6 Ether ($477.76)</td>
            <td>0.00021 Ether ($0.06)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xed637f2d67a13ba095ea02952a1bf508620498b9578d99cf6b6cd8345c17d527">0xed637f2d...</a></td>
            <td><a href="/account/0x55fc2aa9de1e37353fe47a684fcb9dbbd392c792">0x55fc2Aa9dE1E3...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>0.02763156 Ether ($8.25)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xf8afb7f9c384c64715bc158c20c96728ad258b7f4f42793e29532aa1eb9dcb43">0xf8afb7f9...</a></td>
            <td><a href="/account/0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98">0xFBb1b73C4f0BD...</a></td>
            <td><a href="/account/0x37b41c625c130a678af98ab9fafb2cb3301539d4">0x37B41C625C130...</a></td>
            <td>2.995 Ether ($894.31)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xf8effa37e6f2b4c676769dd9d4be63c9d58f11c30cdf9d4a384bf1b03e431e97">0xf8effa37...</a></td>
            <td><a href="/account/0x29c12432830ed201fe2068563d9c8e1e562a1598">0x29C12432830Ed...</a></td>
            <td><a href="/account/0x3e737b54ede58e0fe5b009f2175fdc800e3af54f">0x3E737B54ede58...</a></td>
            <td>2.81558 Ether ($840.73)</td>
            <td>0.00042 Ether ($0.13)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xf98d28a6498b181c055768cc45248077e65356548a4d2897755d58aa02a69d09">0xf98d28a6...</a></td>
            <td><a href="/account/0x6a1424bb183b5f458c309a2db47b07dc131d8040">0x6A1424bb183B5...</a></td>
            <td><a href="/account/0x8d12a197cb00d4747a1fe03395095ce2a5cc6819">0x8d12A197cB00D...</a></td>
            <td>0 Ether ($0.00)</td>
            <td>0.000827968 Ether ($0.25)</td>
        </tr>
        <tr>
            <td><span title="Transaction invoked by contract" class="glyphicon glyphicon-arrow-right">&nbsp;</span><a
                    href="/tx/0x9df571ffef2a276e8ea9590421ca2d82ce9aaa09fbbddf64dc46993af5f263c8">0x9df571...</a></td>
            <td><a href="/account/0x8d12a197cb00d4747a1fe03395095ce2a5cc6819">0x8d12A197cB00D...</a></td>
            <td><a href="/account/0xee609fe292128cad03b786dbb9bc2634ccdbe7fc">0xEe609fE292128...</a></td>
            <td>0 Ether ($0.00)</td>
            <td>0.001154296 Ether ($0.34)</td>
        </tr>
        <tr>
            <td><a href="/tx/0xfa7c4f33f4b4e2410bd2fbef5176c21bc876c7c0ff2a77e15e7c930620be81a1">0xfa7c4f33...</a></td>
            <td><a href="/account/0xea674fdde714fd979de3edf0f56aa9716b898ec8">ethermine</a></td>
            <td><a href="/account/0x90321365460e566ebc16154d1b127a477ce485d7">0x90321365460E5...</a></td>
            <td>0.25054345291068333 Ether ($74.81)</td>
            <td>0.000168 Ether ($0.05)</td>
        </tr>
    </table>
    <h2>Uncles</h2>
    <table class="table table-condensed table-responsive">
        <tr>
            <th>Hash</th>
            <th>Miner</th>
            <th>Number</th>
            <th>Level</th>
            <th>Reward</th>
        </tr>
        <tr>
            <td>0x69342cf1...</td>
            <td><a href="/account/0x829bd824b016326a401d083b33d092293333a830">f2pool</a></td>
            <td>4432990</td>
            <td>1</td>
            <td>2.625 Ether ($783.83)</td>
        </tr>
    </table>
</div>
<hr>
<div class="container">
    <footer><p>© 四川大学嵌入式实验室  |  以太坊区块链浏览器  |  联系我们  |  数据来源：
        <a href="https://www.etherchain.org">www.etherchain.org</a>  |  Powered by Parity v1.7.8</p>
    </footer>
</div>
<script>
    var number=GetQueryString("number");
    var name=GetQueryString("name");
    number=parseInt(number);
    numberpre=parseInt(number)-1;
    numbernext=parseInt(number)+1;
    var myurl="https://etherchain.org/api/block/"+number+":id";
    var myurlpre="block.jsp?number="+numberpre;
    var myurlnext="block.jsp?number="+numbernext;

    $("#previous").attr("href",myurlpre);
    $("#next").attr("href",myurlnext);

    $.getJSON(myurl, function (result) {
        var time=new Date(result.data[0].time).format("yyyy-MM-dd hh:mm:ss");
        $("#hash").append(result.data[0].hash);
        $("#difficulty").append(result.data[0].difficulty);
        $("#gaslimit").append(result.data[0].gasLimit);
        $("#gasusg").append(result.data[0].gasUsed);
        $("#txhash").append(result.data[0].txHash);
        $("#nonce").append(result.data[0].nonce);
        $("#unclehash").append(result.data[0].uncleHash);
        $("#time").append(time);
        $("#root").append(result.data[0].root);
        $("#extra").append(result.data[0].extra);
        $("#size").append(result.data[0].size);
        $("#reward").append(result.data[0].reward);
        $("#miner").append(name);
        $("#blocknumber").append(number);
    })

    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
</script>
</body>
</html>
