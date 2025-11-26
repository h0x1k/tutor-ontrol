import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  base: '/',  // Use absolute paths for production
  build: {
    outDir: 'dist',
    assetsDir: 'assets'
  },
  server: {
    host: true,
    port: 5173
  }
})