
import Image from 'next/image'
import Sample from '../public/1.png'
// import Welcome from '../public/heroflashimage.JPEG'
import Link from 'next/link'



const HomeHeroSection = () => {
    return(
        <>
    <div className="container bg-red-500 px-6 py-4 mx-auto lg:flex lg:h-128 lg:py-16 ">
        <div className="flex flex-col items-center justify-center w-full lg:flex-row lg:w-1/2">
                <h1 className="text-5xl font-bold text-white text-center">VALIANT TRADER NFTS</h1>
                <p className="mt-4 text-center text-white">Own your Valiant NFT Lion Today</p>
                <div className="mt-6">
                    <Link href="/mint">
                        <a 
                            className="inline-block px-3 py-2 font-semibold text-center text-white transition-colors duration-200 transform bg-blue-500 rounded-md hover:bg-blue-400">
                            Mint Now
                        </a>
                    </Link>
                </div>
             <div className="mt-6">
                    <a href="https://discord.gg/sRBQyZvSmh"
                        className="inline-block px-3 py-2 font-semibold text-center text-white transition-colors duration-200 transform bg-blue-500 rounded-md hover:bg-blue-400">
                        Join Discord</a>
                </div>
        </div>
        <div className="flex items-center justify-center w-full mt-2 lg:h-96 lg:w-1/2">
            <Image 
                src={Sample}
                width={400}
                height={400}
                alt='Sample VFT Image'
            />
        </div>
    </div>

          </>
    )
}

export default HomeHeroSection