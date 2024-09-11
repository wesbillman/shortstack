import cors from 'cors'
import express, { type Request, type Response } from 'express'
import { db } from './db'
import { users } from './db/schema'
const app = express()

app.use(cors())
app.use(express.json())

app.get('/api/health', (req: Request, res: Response) => {
  res.json({ status: 'OK' })
})

app.get('/api/users', async (req, res) => {
  try {
    const result = await db.select().from(users)
    res.json(result)
  } catch (error) {
    res.status(500).json({ error })
  }
})

export default app
