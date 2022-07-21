import type { NextPage } from 'next'
import Head from 'next/head'
import Image from 'next/image'
import AboutSection from '../components/AboutSection'
import FeatureSection from '../components/FeaturesSection'
import HomeHeroSection from '../components/HomeHeroSection'
import HomePageNav from '../components/HomePageNav'
import NewHeroSection from '../components/NewHeroSection'
import RoadMapSection from '../components/RoadmapSection'
import TeamSection from '../components/TeamSection'
import styles from '../styles/Home.module.css'

// homepage components


const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <Head>
        <title>Valiant NFT Project</title>
        <meta name="description" content="Generated by create next app" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <HomePageNav />

      <main className='container flex-grow pt-16 mx-auto'>
        <HomeHeroSection />
        <NewHeroSection />
        <AboutSection />
        <FeatureSection />
        <RoadMapSection />
        <TeamSection />
      </main>

      <footer className='w-screen p-10 bg-black text-center text-xl text-white'>
       <span className='my-10'>Copyright 2022 Valiant Trader, LLC. All Rights Reserved.</span>
      </footer>
    </div>
  )
}

export default Home
