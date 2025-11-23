import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    useEffect(() => {
  fetch("http://localhost/rlyeh-hub/api.php")
    .then(response => response.json())
    .then(data => {
     console.log("Resposta do PHP:", data);
    })
    .catch(err => console.error("Erro no fetch:", err));
}, [])

  
  )
}

export default App
