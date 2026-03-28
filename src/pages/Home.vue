<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()

const goAbout = () => {
  router.push('/about')
}
</script>

<template>
  <div class="page home">
    <h2>首页</h2>
    <p>这是首页内容</p>
    <div class="nav-links">
      <router-link to="/about">去关于页</router-link>
      <button @click="goAbout">编程式跳转去关于页</button>
    </div>
  </div>
</template>

<style scoped>
.page {
  padding: 20px;
  border-radius: 8px;
  background: #f0f9ff;
}
.home {
  border: 2px solid #3b82f6;
}
h2 {
  color: #1e40af;
}
.nav-links {
  display: flex;
  gap: 12px;
  margin-top: 16px;
}
a, button {
  padding: 8px 16px;
  background: #3b82f6;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  border: none;
  cursor: pointer;
}
a:hover, button:hover {
  background: #2563eb;
}
</style>
