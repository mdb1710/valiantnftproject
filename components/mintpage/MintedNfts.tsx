interface Props {
    signedIn: boolean,
    supply: number
}

const MintedNfts = (props: Props) => {
    const { signedIn, supply } = props
    return(
        <div className='p-2 justify-around flex items-start border-red-500'>
            <span className='text-3xl'>TOTAL VALIANT NFTS MINTED: <span className='text-3xl'>{!signedIn ? <>-</> : <>{supply}</> } / 10000</span></span>
        </div>
    )
}

export default MintedNfts