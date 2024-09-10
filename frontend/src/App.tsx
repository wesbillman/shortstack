import { useEffect, useState } from 'react'
import logo from './assets/logo.jpg'

function App() {
  const [health, setHealth] = useState<string>('Loading...')

  useEffect(() => {
    const apiUrl = import.meta.env.VITE_API_URL || ''

    fetch(`${apiUrl}/api/health`)
      .then((response) => response.json())
      .then((data) => setHealth(data.status))
      .catch((error) => {
        console.error('Error fetching health status:', error)
        setHealth(error)
      })
  }, [])

  return (
    <div className='flex flex-col items-center justify-center h-screen'>
      <img src={logo} alt='ShortStack Logo' className='w-48 h-auto mb-4' />
      {health && <p>Backend Health: {health}</p>}
    </div>
  )
}

export default App
