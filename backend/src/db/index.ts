import dotenv from 'dotenv'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'

dotenv.config()

const databaseUrl = process.env.DATABASE_URL || 'postgres://localhost:5432/shortstack'
if (!databaseUrl) {
  throw new Error('DATABASE_URL environment variable is not defined')
}

const sql = postgres(databaseUrl)

export const db = drizzle(sql)
