<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()

const goHome = () => {
  router.push('/')
}
</script>

<template>
  <div class="page contact">
    <h2>联系页</h2>
    <p>这是联系页内容</p>
    <div class="nav-links">
      <router-link to="/">返回首页</router-link>
      <router-link to="/about">去关于页</router-link>
      <button @click="goHome">编程式跳转返回首页</button>
    </div>
  </div>
</template>

<style scoped>
.page {
  padding: 20px;
  border-radius: 8px;
  background: #fef3c7;
}
.contact {
  border: 2px solid #f59e0b;
}
h2 {
  color: #b45309;
}
.nav-links {
  display: flex;
  gap: 12px;
  margin-top: 16px;
}
a, button {
  padding: 8px 16px;
  background: #f59e0b;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  border: none;
  cursor: pointer;
}
a:hover, button:hover {
  background: #d97706;
}
</style>
