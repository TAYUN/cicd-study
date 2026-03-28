<script setup lang="ts">
import { RouterView, RouterLink } from 'vue-router'
</script>

<template>
  <div id="app">
    <h1>Vue3 路由跳转测试</h1>
    <nav class="main-nav">
      <RouterLink to="/">首页</RouterLink>
      <RouterLink to="/about">关于</RouterLink>
      <RouterLink to="/contact">联系</RouterLink>
    </nav>
    <main class="main-content">
      <RouterView />
    </main>
  </div>
</template>

<style scoped>
#app {
  font-family: Arial, sans-serif;
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

h1 {
  text-align: center;
  color: #333;
  margin-bottom: 20px;
}

.main-nav {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-bottom: 20px;
  padding: 16px;
  background: #f3f4f6;
  border-radius: 8px;
}

.main-nav a {
  padding: 10px 20px;
  background: #4b5563;
  color: white;
  text-decoration: none;
  border-radius: 6px;
  transition: background 0.3s;
}

.main-nav a:hover {
  background: #374151;
}

.main-nav a.router-link-active {
  background: #1f2937;
  font-weight: bold;
}

.main-content {
  min-height: 300px;
}
</style>
