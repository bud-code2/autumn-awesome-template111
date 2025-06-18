import Image from 'next/image';

export default function Home() {
	return (
		<div className='min-h-screen bg-white flex flex-col font-sans'>
			{/* Header */}
			<header className='w-full flex items-center justify-between px-6 py-4 border-b'>
				<div className='flex items-center gap-2'>
					<span className='text-2xl font-bold text-green-600'>🌈</span>
					<span className='text-xl font-bold'>Tripadvisor</span>
				</div>
				<nav className='hidden md:flex gap-6 text-gray-700 font-medium'>
					<a href='#' className='hover:text-green-600'>
						Discover
					</a>
					<a href='#' className='hover:text-green-600'>
						Trips
					</a>
					<a href='#' className='hover:text-green-600'>
						Review
					</a>
					<a href='#' className='hover:text-green-600'>
						More
					</a>
				</nav>
				<div className='flex items-center gap-3'>
					<button className='px-3 py-1 rounded-full border text-sm font-medium'>USD</button>
					<button className='px-4 py-1 rounded-full bg-black text-white font-semibold text-sm'>
						Sign in
					</button>
				</div>
			</header>

			{/* Main Search Section */}
			<section className='flex flex-col items-center py-12 px-4'>
				<h1 className='text-4xl md:text-5xl font-extrabold mb-6 text-center'>Where to?</h1>
				<div className='flex flex-wrap justify-center gap-4 mb-6'>
					<button className='px-4 py-2 rounded-full bg-gray-100 font-medium text-sm hover:bg-green-100'>
						Search All
					</button>
					<button className='px-4 py-2 rounded-full bg-gray-100 font-medium text-sm hover:bg-green-100'>
						Hotels
					</button>
					<button className='px-4 py-2 rounded-full bg-gray-100 font-medium text-sm hover:bg-green-100'>
						Things to Do
					</button>
					<button className='px-4 py-2 rounded-full bg-gray-100 font-medium text-sm hover:bg-green-100'>
						Restaurants
					</button>
					<button className='px-4 py-2 rounded-full bg-gray-100 font-medium text-sm hover:bg-green-100'>
						Flights
					</button>
					<button className='px-4 py-2 rounded-full bg-gray-100 font-medium text-sm hover:bg-green-100'>
						Vacation Rentals
					</button>
				</div>
				<div className='flex w-full max-w-xl'>
					<input
						type='text'
						placeholder='Places to go, things to do, hotels...'
						className='flex-1 px-4 py-3 rounded-l-full border border-gray-300 focus:outline-none'
					/>
					<button className='px-6 py-3 bg-green-400 text-white font-bold rounded-r-full hover:bg-green-500 transition'>
						Search
					</button>
				</div>
			</section>

			{/* Promo Banner */}
			<section className='flex flex-col md:flex-row items-center justify-center gap-6 px-4 md:px-0 mb-12'>
				<div className='bg-red-300 rounded-xl flex items-center overflow-hidden w-full max-w-3xl'>
					<div className='w-1/2 h-48 md:h-64 relative'>
						<Image
							src='https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80'
							alt='Kayaking'
							fill
							style={{ objectFit: 'cover' }}
						/>
					</div>
					<div className='w-1/2 p-6 flex flex-col justify-center'>
						<h2 className='text-2xl md:text-3xl font-extrabold mb-2'>Book the best part of your trip</h2>
						<p className='mb-4 text-gray-700'>Browse unforgettable things to do—right here.</p>
						<button className='px-4 py-2 bg-black text-white rounded-full font-semibold w-max'>
							Find things to do
						</button>
					</div>
				</div>
			</section>

			{/* Interest Categories */}
			<section className='max-w-5xl mx-auto px-4 mb-12'>
				<h3 className='text-lg font-semibold mb-4'>Find things to do by interest</h3>
				<div className='grid grid-cols-2 md:grid-cols-4 gap-4'>
					<div className='rounded-lg overflow-hidden relative group cursor-pointer'>
						<Image
							src='https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80'
							alt='Outdoors'
							width={400}
							height={200}
							className='group-hover:scale-105 transition-transform duration-300'
						/>
						<span className='absolute bottom-2 left-2 bg-black/60 text-white px-3 py-1 rounded text-sm font-semibold'>
							Outdoors
						</span>
					</div>
					<div className='rounded-lg overflow-hidden relative group cursor-pointer'>
						<Image
							src='https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80'
							alt='Food'
							width={400}
							height={200}
							className='group-hover:scale-105 transition-transform duration-300'
						/>
						<span className='absolute bottom-2 left-2 bg-black/60 text-white px-3 py-1 rounded text-sm font-semibold'>
							Food
						</span>
					</div>
					<div className='rounded-lg overflow-hidden relative group cursor-pointer'>
						<Image
							src='https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80'
							alt='Culture'
							width={400}
							height={200}
							className='group-hover:scale-105 transition-transform duration-300'
						/>
						<span className='absolute bottom-2 left-2 bg-black/60 text-white px-3 py-1 rounded text-sm font-semibold'>
							Culture
						</span>
					</div>
					<div className='rounded-lg overflow-hidden relative group cursor-pointer'>
						<Image
							src='https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=400&q=80'
							alt='Water'
							width={400}
							height={200}
							className='group-hover:scale-105 transition-transform duration-300'
						/>
						<span className='absolute bottom-2 left-2 bg-black/60 text-white px-3 py-1 rounded text-sm font-semibold'>
							Water
						</span>
					</div>
				</div>
			</section>

			{/* Guide Section */}
			<section className='max-w-3xl mx-auto px-4 mb-16'>
				<div className='bg-gray-100 rounded-xl p-6 flex flex-col md:flex-row items-center gap-6'>
					<div className='flex-shrink-0 w-24 h-24 bg-gray-300 rounded-full flex items-center justify-center'>
						<span className='text-3xl'>🐶</span>
					</div>
					<div>
						<h4 className='text-lg font-bold mb-1'>Your go-to guide for dog-friendly travel</h4>
						<p className='text-gray-700 mb-2'>
							Traveling with your dog has never been easier—or more fun. Cities across the country boast
							pet-friendly hotels, parks, and activities.
						</p>
						<a href='#' className='text-green-600 font-semibold hover:underline'>
							Read more
						</a>
					</div>
				</div>
			</section>
		</div>
	);
}
