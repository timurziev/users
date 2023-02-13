<script setup>

import {onMounted, ref} from "vue";

const user = ref([])

const loadUser = async () => await axios.get(`/api/users/${window.location.pathname.split('/')[2]}`).then(response => {
    user.value = response.data.data
})

onMounted(() => loadUser())

const editUser = (user) => {
    axios.put(`/api/users/${user.id}`, {user}).finally(() => loadUser())
}

defineProps({
    authUser: Object,
});
</script>

<template>
    <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <div class="mb-4">
            <label class="block text-gray-700 text-sm font-bold mb-2" for="username">
                Имя
            </label>
            <input v-model="user.name" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" type="text" placeholder="Username">
        </div>
        <div class="mb-6">
            <label class="block text-gray-700 text-sm font-bold mb-2" for="email">
                Email
            </label>
            <input v-model="user.email" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" type="email">
        </div>
        <div class="mb-6">
            <label class="block text-gray-700 text-sm font-bold mb-2" for="phone">
                Телефон
            </label>
            <input v-model="user.phone" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="phone" type="text">
        </div>
        <button @click="editUser(user)" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">
            Сохранить
        </button>
    </form>
</template>

<script>
export default {
    name: "Edit"
}
</script>

<style scoped>

</style>
