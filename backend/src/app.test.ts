import request from 'supertest'
import app from './app'

describe('API Endpoints', () => {
  describe('GET /api/health', () => {
    it('should return a 200 OK status and correct response body', async () => {
      const response = await request(app).get('/api/health')

      expect(response.status).toBe(200)
      expect(response.body).toEqual({ status: 'OK' })
      expect(response.headers['content-type']).toContain('application/json')
    })
  })
})
