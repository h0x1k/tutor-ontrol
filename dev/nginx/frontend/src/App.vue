<template>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <div id="app" class="container py-4">
      <router-view></router-view>
    </div>
  </template>
  
  <script>
  import { onBeforeMount } from 'vue';
  import axios from 'axios';
  import Cookies from 'js-cookie';

  export default {
    name: 'App',
    setup() {
      onBeforeMount(() => {
        axios.defaults.headers.common['X-CSRFToken'] = Cookies.get("csrftoken");
      });
    }
  };
  </script>