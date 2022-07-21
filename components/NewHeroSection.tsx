import Image from 'next/image'
import HeroImage from '../public/valiantheroimage.png'

const NewHeroSection = () => {
    return (
        <>
            <div className="bg-blue-900 w-fill h-96 px-32 py-auto">
                <div className="flex flex-row items-center justify-between">
                    <section className="flex flex-col w-2/5">
                        <h1 className="text-5xl font-bold text-white">The Fast Track To Winning With NFTs</h1>
                        <h2 className="text-2xl text-white">Join our exclusive community of NFT traders, investors and educators</h2>
                        <div className="flex flex-row space-x-4">
                        <div className="mt-6">
                            <a href="https://discord.gg/sRBQyZvSmh"
                                className="inline-block px-3 py-2 font-semibold text-center text-white transition-colors duration-200 transform bg-blue-500 rounded-md hover:bg-blue-400">
                                Discord
                            </a>
                        </div>
                        <div className="mt-6">
                            <a href="https://discord.gg/sRBQyZvSmh"
                                className="inline-block px-3 py-2 font-semibold text-center text-white transition-colors duration-200 transform bg-blue-500 rounded-md hover:bg-blue-400">
                                Opensea
                            </a>
                        </div>
                        </div>
                    </section>
                    <div className='flex flex-row w-2/5 items-center justify-center'>
                        <Image 
                            src={HeroImage}
                            alt='Welcome to Valiant'
                            width={300}
                            height={300}
                        />
                    </div>
                </div>
            </div>
        </>
    )
}

export default NewHeroSection