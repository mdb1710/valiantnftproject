import { useState } from 'react'

interface Props {
    saleStarted: boolean,
    traderNumber: number,
    traderPrice: number,
    traderContract: any,
    walletAddress: String
}

const GetBullNfts = (props: Props) => {
    const { saleStarted, traderNumber, traderPrice, traderContract, walletAddress } = props
    const [newTraderNumber, setNewTraderNumber] = useState(traderNumber)
    const valueNumber = traderNumber.toString()

    const handleTraderNumber = (e: any) => {
        e.preventDefault()
        console.log("Posse member amount selected")
        setNewTraderNumber(newTraderNumber)
        console.log("new number is", newTraderNumber)
    }

    const mintTraderNft = async(how_many_traders: number) => {
        if(traderContract != null) {
            const price = traderPrice * how_many_traders

            // const gasAmount = await memberContract.mintPosseMember(how_many_members).estimateGas({ from: walletAddress, value: price })
            // console.log("estimated gas",gasAmount)

            traderContract.methods
                .mintTraderNft(how_many_traders)
                .send({from: walletAddress, value: price, type: "0x2"})
                .on('transactionHash', function(hash: any){
                    console.log("transactionHash", hash)
                })
        } else {
            console.log("Wallet not connected")
        }
    }

    return(
        <div className='flex items-center justify-center my-10'>
        <div className='p-2 justify-around flex flex-col items-center border-red-500 w-1/2'>
            <span className='text-3xl'>I want </span>
            <div className='text-2xl'>
                <select name="members" id="traderMembers" value={traderNumber} onChange={handleTraderNumber}>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                </select>
            </div>
            <span className='text-3xl'> VALIANT TRADERS</span>
            {saleStarted ? <button className="bg-red-500 hover:bg-red-500 text-white font-bold py-2 px-4 mt-5 rounded max-w-xl" onClick={() => mintTraderNft(newTraderNumber)}>MINT {newTraderNumber} Jungle Posse Members for {(traderPrice * newTraderNumber) / (10 ** 18)} ETH + GAS</button> : <button className='bg-red-500 hover:bg-red-500 text-white font-bold py-2 px-4 mt-5 rounded'>SALE IS NOT ACTIVE OR NO WALLET IS CONNECTED</button>}
        </div>
        </div>
    )
}

export default GetBullNfts