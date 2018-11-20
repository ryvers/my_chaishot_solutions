const {web3} = require('./setup');

/**
 * Given an account address on the ethereum blockchain find 
 * all the addresses that were sent ether from that address
 * @param {string} address - The hexidecimal address for the account
 * @async
 * @returns {Array} all the addresses that receieved ether
 */
async function findAddresses(_address) {
    var address = web3.utils.toChecksumAddress(_address);
    var toAddresses = [];
    var toAddressesFromOneBlock
    var currentBlock = await web3.eth.getBlockNumber();
    console.log('CurrentBlock : ' + currentBlock);
    var n = await web3.eth.getTransactionCount(address);
    console.log('Transaction count : ' + n);
    for (var i = currentBlock; i >= 0 && n > 0; --i) {
        try {
            console.log('Checking block : ' + i);
            var block = await web3.eth.getBlock(i, true);
            //console.log('Miner who mined transaction : ' + block.miner);
            if (block && block.transactions) {
                toAddressesFromOneBlock = block.transactions.filter((e) => {
                    if (address == e.from) {
                        return e;
                    }
                }).map((e) => {
                    return e.to;
                });
                console.log(toAddressesFromOneBlock);
                n = n - toAddressesFromOneBlock.length;
                toAddressesFromOneBlock.forEach((x) => { toAddresses.push(x); });
            }


        } catch (e) { console.error("Error in block " + i, e); }
    }
    console.log('ToAddressesFound: ' + toAddresses);
    return toAddresses;
}

export default findAddresses;