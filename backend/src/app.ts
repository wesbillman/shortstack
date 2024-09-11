import cors from 'cors'
import express, { type Request, type Response } from 'express'
const app = express()

app.use(cors())
app.use(express.json())

app.get('/api/health', (req: Request, res: Response) => {
  res.json({ status: 'OK' })
})

export default app
