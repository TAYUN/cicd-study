<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()

const goContact = () => {
  router.push('/contact')
}
</script>

<template>
  <div class="page about">
    <h2>关于页</h2>
    <p>这是关于页内容</p>
    <div class="nav-links">
      <router-link to="/">返回首页</router-link>
      <router-link to="/contact">去联系页</router-link>
      <button @click="goContact">编程式跳转去联系页</button>
    </div>
  </div>
</template>

<style scoped>
.page {
  padding: 20px;
  border-radius: 8px;
  background: #f0fdf4;
}
.about {
  border: 2px solid #22c55e;
}
h2 {
  color: #15803d;
}
.nav-links {
  display: flex;
  gap: 12px;
  margin-top: 16px;
}
a, button {
  padding: 8px 16px;
  background: #22c55e;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  border: none;
  cursor: pointer;
}
a:hover, button:hover {
  background: #16a34a;
}
</style>
